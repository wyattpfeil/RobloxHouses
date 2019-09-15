script.Parent.Text = script.Parent.Name

script.Parent.MouseButton1Down:Connect(function()
	script.Parent.Parent.SelectedPart.Value.Material = Enum.Material[script.Parent.Name]
end)