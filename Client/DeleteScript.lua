local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local DeletingWalls = false

script.Parent.MouseButton1Down:Connect(function()
	print("Clicked trash!")
	if DeletingWalls == false then
		DeletingWalls = true
		script.Parent.Position = UDim2.new(script.Parent.Position.X.Scale, 0, script.Parent.Position.Y.Scale + 0.1, 0)
	else
		DeletingWalls = false
		script.Parent.Position = UDim2.new(script.Parent.Position.X.Scale, 0, script.Parent.Position.Y.Scale - 0.1, 0)
	end
end)

Mouse.Button1Down:Connect(function()
	if DeletingWalls == true then
		if Mouse.Target.Name == "WallSection" or Mouse.Target.Name == "WallSectionRotated" then
			game.ReplicatedStorage.DeleteEvent:FireServer(Mouse.Target.Name, Mouse.Target.Position)
			--Mouse.Target:Destroy()
		elseif game.Lighting.FurnitureItems[Mouse.Target.Parent.Name] then
			game.ReplicatedStorage.DeleteEvent:FireServer(Mouse.Target.Parent.Name, Mouse.Target.Parent.PrimaryPart.Position)
			--Mouse.Target.Parent:Destroy()
		end
	end
end)
