local HouseItemsStore = game.DataStoreService:GetDataStore("HouseItemsStore")
local HouseWallsStore = game.DataStoreService:GetDataStore("HouseWallsStore")

local function decodeCFrame(cf) 
    return CFrame.new(unpack(cf))
end
function loadColorFromDataStore(t)
    return Color3.new(t.r, t.g, t.b)
end
local TableToVector = function(tab)
    return Vector3.new(tab[1],tab[2],tab[3])
end
local function getWriteableMaterial(Material)
	local SplitMaterial = string.split(Material, ".")
	print("Material is " .. SplitMaterial[3])
	return Enum.Material[SplitMaterial[3]]	
end

function isInTable(tableValue, toFind)
	local found = false
	for _,v in pairs(tableValue) do
		if v==toFind then
			found = true
            break;
		end
	end
	return found
end

game.Players.PlayerAdded:Connect(function(Player)
	local children = game.Workspace.NewHouses:GetChildren()
	for i = 1, #children do
		local child = children[i]
		if child.Name == "SpaceForPlot" then
			child.Name = "HousePlot" .. Player.Name
			break
		end
	end
	local ItemsTable = HouseItemsStore:GetAsync(Player.Name)
	if ItemsTable ~= nil then
		for i = 1, #ItemsTable do
			local Item = ItemsTable[i]
			print(Item)
			local ItemName = Item[1]
			local ItemCFrame = Item[2]
			print(ItemName)
			print(ItemCFrame)
			local ItemClone = game.Lighting.FurnitureItems[ItemName]:Clone()
			ItemClone.Parent = game.Workspace.NewHouses["HousePlot" .. Player.Name]
			ItemClone:SetPrimaryPartCFrame(decodeCFrame(ItemCFrame))
		end
	end
	local WallsTable = HouseWallsStore:GetAsync(Player.Name)
	if WallsTable ~= nil then
		print("Walls Table is not nil")
		for i = 1, #WallsTable do
			local Item = WallsTable[i]
			local Size = TableToVector(Item[1])
			local Cframe = decodeCFrame(Item[2])
			local Color = loadColorFromDataStore(Item[3])
			local Material = getWriteableMaterial(Item[4])
			local WallClone = game.Workspace.WallSection:Clone()
			WallClone.Parent = game.Workspace.NewHouses["HousePlot" .. Player.Name]
			WallClone.Size = Size
			WallClone.CFrame = Cframe
			WallClone.Color = Color
			WallClone.Material = Material
			print("Actual Material is " .. tostring(WallClone.Material))
			print("Loaded A Wall!")
		end
	end
	local Positions = {}
	local WallPositions = {}
	local HousePlotChildren = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i = 1, #HousePlotChildren do
		local child = HousePlotChildren[i]
		if child:IsA("Model") then
			local Pos = child.PrimaryPart.CFrame
			if isInTable(Positions, Pos) then
				child:Destroy()
				print("Destroyed " .. child.Name)
			else
				table.insert(Positions, Pos)
			end
		elseif child:IsA("Part") then
			local Pos = child.CFrame
			if isInTable(WallPositions, Pos) then
				child:Destroy()
				print("Destroyed " .. child.Name)
			else
				table.insert(WallPositions, Pos)
			end
		end
	end
end)