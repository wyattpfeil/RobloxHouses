local function SaveHouse(Player, ObjectName, Pos)
	local ObjClone = game.Lighting.FurnitureItems[ObjectName]:Clone()
	ObjClone.Parent = game.Workspace.NewHouses["HousePlot" .. Player.Name]
	ObjClone:SetPrimaryPartCFrame(Pos)
	local children =  game.Workspace.NewHouses["HousePlot" .. Player.Name]:GetChildren()
	for i, child in ipairs(children) do
		if child:IsA("Model") then
			if #child:GetChildren() == 0 then
				child:Destroy()
			end
		end
	end
end	

game.ReplicatedStorage.SaveHouseEvent.OnServerEvent:Connect(SaveHouse)