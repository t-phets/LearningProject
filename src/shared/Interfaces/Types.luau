-- Shared/Interfaces/Types.luau
--!strict

-- ใครก็ตามที่มีฟังก์ชัน TakeDamage และ IsDead จะถือว่าเป็น IDamageable
export type IDamageable = {
    TakeDamage: (self: any, amount: number) -> (),
    IsDead: (self: any) -> boolean,
}

-- ใครก็ตามที่มีฟังก์ชัน Heal จะถือว่าเป็น IHealable
export type IHealable = {
    ReceiveHeal: (self: any, amount: number) -> (),
    IsDead: (self: any) -> boolean,
}

return {}