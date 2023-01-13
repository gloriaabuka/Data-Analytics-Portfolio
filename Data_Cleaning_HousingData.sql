-- Data Cleaning Project
-- take a look at data
select *
from Test..NashvileHousing$

-- Standardize SaleDate Format
select SaleDate, CONVERT(Date, SaleDate)
from Test..NashvileHousing$

-- Updating the date with the change
ALTER TABLE NashvileHousing$
Add Converted_Date Date;

UPDATE NashvileHousing$
set Converted_Date = CONVERT(Date, SaleDate)



-- Populate the property address column
select *
from Test..NashvileHousing$
where PropertyAddress is null

-- some homes have same parcel Id and property address but different unique Id
select a.ParcelID, a.PropertyAddress, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from Test..NashvileHousing$ as a
join Test..NashvileHousing$ as b
	on a.ParcelID = b.ParcelID and
	a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from Test..NashvileHousing$ as a
join Test..NashvileHousing$ as b
	on a.ParcelID = b.ParcelID and
	a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null

-- Address column needs to be broken down for easy analysis because it contains a delimiter(,)
select PropertyAddress
from Test..NashvileHousing$

select
substring(PropertyAddress, 1, charindex(',', PropertyAddress)-1) as Address, 
substring(PropertyAddress, charindex(',', PropertyAddress)+1, Len(PropertyAddress)) as Address
from Test..NashvileHousing$

-- Updating the date with the change
--create 2 new columns to hold the information split
ALTER TABLE NashvileHousing$
Add PropertySplitAddress Nvarchar(255);

UPDATE NashvileHousing$
set PropertySplitAddress = substring(PropertyAddress, 1, charindex(',', PropertyAddress)-1)

ALTER TABLE NashvileHousing$
Add PropertySplitCity Nvarchar(255);

UPDATE NashvileHousing$
set PropertySplitCity = substring(PropertyAddress, charindex(',', PropertyAddress)+1, Len(PropertyAddress))


--Splitting the owner Address column
select OwnerAddress
from Test..NashvileHousing$

select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from Test..NashvileHousing$

-- update the Table
ALTER TABLE NashvileHousing$
Add OwnerSplitAddress Nvarchar(255);

UPDATE NashvileHousing$
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvileHousing$
Add OwnerSplitCity Nvarchar(255);

UPDATE NashvileHousing$
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvileHousing$
Add OwnerSplitState Nvarchar(255);

UPDATE NashvileHousing$
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-- Make the soldasVaccant column values uniform (We currently have Yes, No, Y, N)

select SoldAsVacant,
	CASE when SoldAsVacant = 'Y' THEN 'YES'
		when SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END
from Test..NashvileHousing$

update NashvileHousing$
set SoldAsVacant = CASE when SoldAsVacant = 'Y' THEN 'YES'
		when SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END

-- check to be sure
select distinct(SoldAsVacant), Count(SoldAsVacant)
from Test..NashvileHousing$
Group by SoldAsVacant
order by 2


-- Remove Duplicates
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Test..NashvileHousing$
--order by ParcelID
)
delete 
From RowNumCTE
where row_num > 1


-- Delete irrelant column (Unused Data)
ALTER TABLE Test..NashvileHousing$
DROP COLUMN OwnerAddress, PropertyAddress

ALTER TABLE Test..NashvileHousing$
DROP COLUMN SaleDate


select *
from Test..NashvileHousing$

