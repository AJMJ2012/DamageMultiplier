version "4.0.0"

// Damage dealt and received multiplier
// Can't modify damage with WorldThingDamaged, so using an inventory item is the next best thing.

const debug = 0;

class DamageMultiplier_EventHandler : StaticEventHandler {
	override void PlayerSpawned(PlayerEvent e) {
		players[e.PlayerNumber].mo.GiveInventory("DamageMultiplierHandler", 1);
	}
	override void PlayerRespawned(PlayerEvent e) {
		players[e.PlayerNumber].mo.GiveInventory("DamageMultiplierHandler", 1);
	}
}

class DamageMultiplierHandler : Inventory
{
	Default {
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNCLEARABLE;
		+INVENTORY.PERSISTENTPOWER;
	}

	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags) {
		if (passive && !source.player) {
			newdamage *= Max(0.0, CVar.GetCVar("sv_damagereceivedfactor").GetFloat());
		}
		else {
			newdamage *= Max(0.0, CVar.GetCVar("sv_damagedealtfactor").GetFloat());
		}
	}
}