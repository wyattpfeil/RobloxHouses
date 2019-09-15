local FurnitureItems = game.Lighting.FurnitureItems:GetChildren()
for i = 1, #FurnitureItems do
	local Item = FurnitureItems[i]
    local Object = script.Parent.Example:Clone()
	Object.Parent = script.Parent
	Object.Name = Item.Name
	Object.Text = Item.Name
end
script.Parent.Example:Destroy()