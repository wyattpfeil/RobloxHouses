local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

script.Parent.MouseButton1Down:Connect(function()
	local children = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i, child in ipairs(children) do
		child:Destroy()
	end
	game.ReplicatedStorage.ClearEvent:FireServer()
end)