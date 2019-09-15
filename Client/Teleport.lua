local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Building = false

script.Parent.MouseButton1Down:Connect(function()
	Player.Character:SetPrimaryPartCFrame(CFrame.new(game.Workspace.NewHouses["HousePlot" .. Player.Name].CFrame.X, Player.Character.PrimaryPart.CFrame.Y,game.Workspace.NewHouses["HousePlot" .. Player.Name].CFrame.Z))
end)