local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local PlacingFirst = false
local PlacingSecond = false
local PlacementGuideClone = nil

local Pad = game.Workspace.NewHouses["HousePlot" .. Player.Name]
local WallSectionPlacementClone = nil
--local PlacingPadRegion = Region3.new(Vector3.new(Pad.Position.X - Pad.Size.X/2, Pad.Position.Y, Pad.Position.Z - Pad.Size.Z/2), Vector3.new(Pad.Position.X + Pad.Size.X/2, Pad.Position.Y, Pad.Position.Z + Pad.Size.Z/2))

local WallBase1 = nil
local WallBase2 = nil

function CreateRegion3FromPart(Part)
    return Region3.new(Part.Position-(Part.Size/2),Part.Position+(Part.Size/2))
end

local PlacingPadRegion = CreateRegion3FromPart(Pad)

local function round(n)
	return math.floor(n + 0.5)
end

function isInRegion3(region, point)
    local relative = (point - region.CFrame.p) / region.Size
    return -0.5 <= relative.X and relative.X <= 0.5
       and -100 <= relative.Y and relative.Y <= 100
       and -0.5 <= relative.Z and relative.Z <= 0.5
end

script.Parent.MouseButton1Down:Connect(function()
	PlacingFirst = true	
	PlacementGuideClone = game.Workspace.WallBaseRotated:Clone()
	PlacementGuideClone.Parent = game.Workspace
	PlacementGuideClone.CanCollide = false
	PlacementGuideClone.Transparency = 0.5
	PlacementGuideClone.BrickColor = BrickColor.new("Baby blue")
	Mouse.Move:Connect(function()
		if PlacingFirst == true then
			PlacementGuideClone.Position = Vector3.new(round(Mouse.hit.p.X), PlacementGuideClone.Position.Y, round(Mouse.hit.p.Z))
		end
	end)
end)


--print(round(13.5))
local FirstWallPos = nil
local SecondWallPos = nil

Mouse.Button1Down:Connect(function()
	if PlacingFirst == true then
		print(Mouse.hit.p)
		print(isInRegion3(PlacingPadRegion, Mouse.hit.p))
		if isInRegion3(PlacingPadRegion, Mouse.hit.p) then
			local WallBase = game.Workspace.WallBaseRotated:Clone()
			WallBase.Parent = game.Workspace
			WallBase.BrickColor = BrickColor.new("Baby blue")
			WallBase.Position =	Vector3.new(round(Mouse.hit.p.X), WallBase.Position.Y, round(Mouse.hit.p.Z))
			FirstWallPos = WallBase.Position
			PlacingFirst = false
			PlacingSecond = true
			PlacementGuideClone.BrickColor = BrickColor.new("Baby blue")
			Mouse.Move:Connect(function()
				if PlacingSecond == true then
					PlacementGuideClone.Position = Vector3.new(round(Mouse.Hit.p.X), PlacementGuideClone.Position.Y, round(PlacementGuideClone.Position.Z))
				end
			end)
			WallBase1 = WallBase
		end
	end
end)

Mouse.Button1Up:Connect(function()
	if PlacingSecond == true then
		if isInRegion3(PlacingPadRegion, Mouse.hit.p) then
			local WallBase = game.Workspace.WallBaseRotated:Clone()
			WallBase.Parent = game.Workspace
			WallBase.Position = Vector3.new(round(Mouse.hit.p.X), WallBase.Position.Y, FirstWallPos.Z)
			SecondWallPos = WallBase.Position
			local FullWallClone = game.Workspace.WallSection:Clone()
			FullWallClone.Parent = Pad
			if Mouse.hit.p.X > FirstWallPos.X then
				print("Greater")
				FullWallClone.Size = Vector3.new(SecondWallPos.X - FirstWallPos.X, FullWallClone.Size.Y, FullWallClone.Size.X)
				FullWallClone.Position = Vector3.new((SecondWallPos.X + FirstWallPos.X)/2, SecondWallPos.Y, SecondWallPos.Z)
			else
				print("Less")
				FullWallClone.Size = Vector3.new(FirstWallPos.X - SecondWallPos.X, FullWallClone.Size.Y, FullWallClone.Size.X)
				FullWallClone.Position = Vector3.new((FirstWallPos.X + SecondWallPos.X)/2, SecondWallPos.Y, SecondWallPos.Z)
			end
			PlacingSecond = false
			PlacementGuideClone:Destroy()
			PlacementGuideClone = nil
			WallBase2 = WallBase
			WallBase1:Destroy()
			WallBase1 = nil
			WallBase2:Destroy()
			WallBase2 = nil
		else
			PlacingSecond = false
			WallBase1:Destroy()
			WallBase1 = nil
			PlacementGuideClone:Destroy()
			PlacementGuideClone = nil
		end
	end
end)