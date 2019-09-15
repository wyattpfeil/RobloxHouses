local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local ChangingColor = false

script.Parent.MouseButton1Down:Connect(function()
	script.Parent.Parent.Visible = false
	script.Parent.Parent.ColorPallete.SelectedPart.Value.Color = script.Parent.Parent.OldColor.Value
end)
