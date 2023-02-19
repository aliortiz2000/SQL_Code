/*
Cleaning Data in SQL Queries
*/


Select *
From Nashville_Housing..Nashville_Housing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


SELECT SaleDate,  CONVERT (date, SaleDate) AS SaleDateCONVERT
FROM Nashville_Housing..Nashville_Housing


--UPDATE Nashville_Housing..Nashville_Housing
--SET SaleDate = CONVERT (date, SaleDate) 


ALTER TABLE Nashville_Housing 
ADD SaleDateConverted Date


UPDATE Nashville_Housing..Nashville_Housing
SET SaleDateConverted = CONVERT (date, SaleDate) 


---------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data


SELECT *
FROM Nashville_Housing..Nashville_Housing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM Nashville_Housing..Nashville_Housing a JOIN Nashville_Housing..Nashville_Housing b
	ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE b.PropertyAddress IS NULL


UPDATE a
SET a.PropertyAddress = ISNULL (a.PropertyAddress, B.PropertyAddress)
FROM Nashville_Housing..Nashville_Housing a JOIN Nashville_Housing..Nashville_Housing b
	ON a.ParcelID = b.ParcelID AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


SELECT PropertyAddress
FROM Nashville_Housing..Nashville_Housing
ORDER BY PropertyAddress


SELECT SUBSTRING (PropertyAddress, 1,  CHARINDEX (',', PropertyAddress) -1) AS Address, 
SUBSTRING (PropertyAddress, CHARINDEX (',', PropertyAddress) +1, LEN (PropertyAddress)) AS City
FROM Nashville_Housing..Nashville_Housing
ORDER BY PropertyAddress


ALTER TABLE Nashville_Housing 
ADD PropertySplitAddress Nvarchar (255)


UPDATE Nashville_Housing..Nashville_Housing
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1,  CHARINDEX (',', PropertyAddress) -1)


ALTER TABLE Nashville_Housing 
ADD PropertySplitCity Nvarchar (255)


UPDATE Nashville_Housing..Nashville_Housing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX (',', PropertyAddress) +1, LEN (PropertyAddress)) 


SELECT PropertySplitAddress, PropertySplitCity
FROM Nashville_Housing..Nashville_Housing
ORDER BY PropertyAddress



SELECT OwnerAddress
FROM Nashville_Housing..Nashville_Housing


SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM Nashville_Housing..Nashville_Housing


ALTER TABLE Nashville_Housing..Nashville_Housing
ADD OwnerSplitAddress Nvarchar (255)


UPDATE Nashville_Housing..Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Nashville_Housing..Nashville_Housing
ADD OwnerSplitCity Nvarchar (255)


UPDATE Nashville_Housing..Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE Nashville_Housing..Nashville_Housing
ADD OwnerSplitState Nvarchar (255)


UPDATE Nashville_Housing..Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


SELECT SoldAsVacant, COUNT (*)
FROM Nashville_Housing..Nashville_Housing
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldASVacant, 
	CASE 
		WHEN SoldASVacant = 'N' THEN 'No'
		WHEN SoldASVacant = 'Y' THEN 'Yes'
		ELSE SoldASVacant
	END AS Result
FROM Nashville_Housing..Nashville_Housing
ORDER BY 1 


UPDATE Nashville_Housing..Nashville_Housing
SET SoldASVacant = CASE 
						WHEN SoldASVacant = 'N' THEN 'No'
						WHEN SoldASVacant = 'Y' THEN 'Yes'
						ELSE SoldASVacant
					END


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates


/*
	The main advantage of the Common Table Expression is the encapsulation, 
	instead of having to declare the subquery in every place you want to 
	use it, you can define it once, but have multiple references to it.
*/

WITH RowNumCTE AS(
	SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY
						UniqueID
						) Row_Num

	FROM Nashville_Housing..Nashville_Housing
)

SELECT *
FROM RowNumCTE
WHERE Row_Num > 1
ORDER BY PropertyAddress


/*
	With a subquery you can obtain the same result but it will only work once. 
*/

SELECT *
FROM 
(
	SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY
						UniqueID
						) Row_num

	FROM Nashville_Housing..Nashville_Housing
) AS Row_Num
WHERE Row_Num > 1
ORDER BY PropertyAddress


/* 
	New table with the columns of the previous one to keep the information 
	without duplicates, and not delete the data.
*/

SELECT *  Nashville_Housing_Clean 
FROM Nashville_Housing..Nashville_Housing 
WHERE 0 = 1


ALTER TABLE Nashville_Housing..Nashville_Housing_Clean
ADD Row_Num int


INSERT INTO Nashville_Housing..Nashville_Housing_Clean  
	SELECT *
	FROM 
	(
		SELECT *,
			ROW_NUMBER() OVER (
			PARTITION BY ParcelID,
						 PropertyAddress,
						 SalePrice,
						 SaleDate,
						 LegalReference
						 ORDER BY
							UniqueID
							) Row_num

		FROM Nashville_Housing..Nashville_Housing
	) AS Row_Num
	WHERE Row_Num = 1
	ORDER BY PropertyAddress


SELECT *   
FROM Nashville_Housing..Nashville_Housing_Clean


-------------------------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


ALTER TABLE Nashville_Housing_Clean
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate, Row_Num


-----------------------------------------------------------------------------------------------
