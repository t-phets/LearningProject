--!strict
local Health = {}
Health.__index = Health

function Health.new(maxValue: number): Health
    local self = setmetatable({}, Health)
    self.Max = maxValue
    self.Current = maxValue
    self.IsDepleted = false
    return (self :: any) :: Health
end

function Health.Damage(self: Health, amount: number)
    self.Current = math.max(0, self.Current - amount)
    if self.Current <= 0 then
        self.IsDepleted = true
    end
end

function Health.Restore(self: Health)
    self.Current = self.Max
    self.IsDepleted = false
end

export type Health = typeof(setmetatable({} :: {
    Max: number,
    Current: number,
    IsDepleted: boolean,
}, Health))

return Health