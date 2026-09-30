-- Shared/Interfaces/CombatInterfaces.luau
--!strict

-- ข้อตกลง ใครก็ตามที่มีฟังก์ชัน TakeDamage และ IsDead จะถือว่าเป็น IDamageable และโดนดาเมจได้
export type IDamageable = {
    TakeDamage: (self: any, amount: number) -> (),
    IsDead: (self: any) -> boolean,
}

-- ข้อตกลง ใครก็ตามที่มีฟังก์ชัน RecieveHeal จะถือว่าเป็น IHealable และได้รับการรักษาได้
export type IHealable = {
    ReceiveHeal: (self: any, amount: number) -> (),
    IsDead: (self: any) -> boolean,
}

return {}