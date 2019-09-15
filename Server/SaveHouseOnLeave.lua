local HouseItemsStore = game.DataStoreService:GetDataStore("HouseItemsStore")
local HouseWallsStore = game.DataStoreService:GetDataStore("HouseWallsStore")

local function encodeCFrame(cf) 
    return {cf:components()}
end
function getSaveableColor3(color)
    return {r = color.r, g = color.g, b = color.b}
end
local VectorToTable = function(vec)
    return {vec.X,vec.Y,vec.Z}
end
function getSaveableMaterial(Material)
	return tostring(Material)
end

game.Players.PlayerRemoving:Connect(function(Player)
	print(Player.Name .. " left the game!")
	local HouseItems = {}
	local HouseWalls = {}
	local PlayerPad = game.Workspace.NewHouses["HousePlot" .. Player.Name]
	local children = PlayerPad:GetChildren()
	for i = 1, #children do
		local child = children[i]
		if child:IsA("Model") then
			print(child.Name)
			local ModelChildren = child:GetChildren()
			if #ModelChildren ~= 0 then
				local ModelData = {}
				table.insert(ModelData, child.Name)
				table.insert(ModelData, encodeCFrame(child.PrimaryPart.CFrame))
				table.insert(HouseItems, ModelData)
			end
		elseif child:IsA("Part") then
			print(child.Name .. " is a part")
			local PartData = {}
			table.insert(PartData, VectorToTable(child.Size))
			table.insert(PartData, encodeCFrame(child.CFrame))
			table.insert(PartData, getSaveableColor3(child.Color))
			table.insert(PartData, getSaveableMaterial(child.Material))
			table.insert(HouseWalls, PartData)
		end
	end
	for i = 1, #HouseWalls do
		local Item = HouseWalls[i]
		print(Item[1])
		print(Item[2])
		print(Item[3])
		print(Item[4])
	end
	HouseItemsStore:SetAsync(Player.Name, HouseItems)
	HouseWallsStore:SetAsync(Player.Name, HouseWalls)
	local HousePlotChildren = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i = 1, #HousePlotChildren do
		local Object = HousePlotChildren[i]
		Object:Destroy()
	end
	game.Workspace.NewHouses["HousePlot" .. Player.Name].Name = "SpaceForPlot"
end)