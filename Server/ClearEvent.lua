local function Clear(Player)
	local children = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i, child in ipairs(children) do
		child:Destroy()
	end
end	

game.ReplicatedStorage.ClearEvent.OnServerEvent:Connect(Clear)