local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local ChangingMaterial = false

script.Parent.MouseButton1Down:Connect(function()
	script.Parent.Parent.Visible = false
end)
