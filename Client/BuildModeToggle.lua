local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Building = false

script.Parent.MouseButton1Down:Connect(function()
	if Building == false then
		Building = true
		script.Parent.Parent.Parent.Parent.NewHouseUi.Enabled = true
		script.Parent.Parent.TextLabel.Text = "Exit Build Mode"
	else
		Building = false
		script.Parent.Parent.Parent.Parent.NewHouseUi.Enabled = false
		script.Parent.Parent.TextLabel.Text = "Enter Build Mode"
		local children = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
		for i, child in ipairs(children) do
			if child:IsA("Model") then
				print(child.Name .. " is child number " .. i)
				game.ReplicatedStorage.SaveHouseEvent:FireServer(child.Name, child.PrimaryPart.CFrame)
				child:Destroy()
			elseif child:IsA("Part") then
				game.ReplicatedStorage.SaveHouseWallsEvent:FireServer(child.Size, child.CFrame, child.Color, child.Material)
				child:Destroy()
			end
		end
	end
end)