local function SaveHouseWalls(Player, WallSize, WallCFrame, WallColor, WallMaterial)
	local WallClone = game.Workspace.WallSection:Clone()
	WallClone.Parent = game.Workspace.NewHouses["HousePlot" .. Player.Name]
	WallClone.Size = WallSize
	WallClone.CFrame = WallCFrame
	WallClone.Color = WallColor
	WallClone.Material = WallMaterial
	print(WallClone.Name)
end	

game.ReplicatedStorage.SaveHouseWallsEvent.OnServerEvent:Connect(SaveHouseWalls)