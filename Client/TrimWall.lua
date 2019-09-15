local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Trimming = false
local SizePartFromDir = require(game.ReplicatedStorage.SizePartFromDirection)
PlacementGuideClone = nil

local function round(n)
	return math.floor(n + 0.5)
end


script.Parent.MouseButton1Down:Connect(function()
	if Trimming == false then
		Trimming = true
		script.Parent.Parent.TextLabel.Text = "Stop Triming Wall Size"
		PlacementGuideClone = game.Workspace.WallBaseRotated:Clone()
		PlacementGuideClone.Parent = game.Workspace
		PlacementGuideClone.CanCollide = false
		PlacementGuideClone.Transparency = 0.5
		PlacementGuideClone.BrickColor = BrickColor.new("Baby blue")
		Mouse.Move:Connect(function()
			if Trimming == true then
				PlacementGuideClone.Position = Vector3.new(round(Mouse.hit.p.X), PlacementGuideClone.Position.Y, round(Mouse.hit.p.Z))
			end
		end)
	else
		Trimming = false
		script.Parent.Parent.TextLabel.Text = "Trim Wall Size"
		PlacementGuideClone:Destroy()
		PlacementGuideClone = nil
	end

end)

Mouse.Button1Down:Connect(function()
	if Trimming == true then
		local Target = Mouse.Target
		local HitPosX = PlacementGuideClone.Position.X
		local HitPosZ = PlacementGuideClone.Position.Z
		if Target.Name == "WallSection" then
			print("Target Is a Wall Section")
			if Target.Parent.Name == "HousePlot" .. Player.Name then
				print("Target Is Inside the Plot")
				if Target.Size.X > Target.Size.Z then
					print("X WALL")
					if HitPosX >= Target.Position.X then
						SizePartFromDir.SizePartFromLeft(Target, HitPosX - (Target.Position.X + Target.Size.X/2))
					else
						SizePartFromDir.SizePartFromRight(Target, -(HitPosX - (Target.Position.X - Target.Size.X/2)))
					end
				else
					print("Z WALL")
					if HitPosZ >= Target.Position.Z then
						SizePartFromDir.SizePartFromLeftZ(Target, HitPosZ - (Target.Position.Z + Target.Size.Z/2))
					else
						SizePartFromDir.SizePartFromRightZ(Target, -(HitPosZ - (Target.Position.Z - Target.Size.Z/2)))
					end
				end
			end
		end
	end
end)