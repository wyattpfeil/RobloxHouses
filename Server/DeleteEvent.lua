local function Delete(Player, ObjectName, ObjectPosition)
	local children = game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i, child in ipairs(children) do
		if child.Name == ObjectName then
			if child:IsA("Part") then
				if child.Position == ObjectPosition then
					child:Destroy()
				end
			elseif child:IsA("Model") then
				if child.PrimaryPart.Position == ObjectPosition then
					child:Destroy()
				end
			end
		end
	end
end	

game.ReplicatedStorage.DeleteEvent.OnServerEvent:Connect(Delete)