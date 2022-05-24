class Cause
  def self.name_arr(name_str=nil, idx=false)
    ar = [
      :MOD_UNKNOWN,
      :MOD_SHOTGUN,
      :MOD_GAUNTLET,
      :MOD_MACHINEGUN,
      :MOD_GRENADE,
      :MOD_GRENADE_SPLASH,
      :MOD_ROCKET,
      :MOD_ROCKET_SPLASH,
      :MOD_PLASMA,
      :MOD_PLASMA_SPLASH,
      :MOD_RAILGUN,
      :MOD_LIGHTNING,
      :MOD_BFG,
      :MOD_BFG_SPLASH,
      :MOD_WATER,
      :MOD_SLIME,
      :MOD_LAVA,
      :MOD_CRUSH,
      :MOD_TELEFRAG,
      :MOD_FALLING,
      :MOD_SUICIDE,
      :MOD_TARGET_LASER,
      :MOD_TRIGGER_HURT,
      #ifdef MISSIONPACK
      :MOD_NAIL,
      :MOD_CHAINGUN,
      :MOD_PROXIMITY_MINE,
      :MOD_KAMIKAZE,
      :MOD_JUICED,
      #endif
      :MOD_GRAPPLE
    ]
    
    return ar if name_str.nil?
    idx.nil? ? ar[ar.index(name_str.to_sym)] : ar.index(name_str.to_sym)
  end
  
  def self.name_h(name_str=nil)
    h = {
      MOD_UNKNOWN: 'MOD_UNKNOWN',
      MOD_SHOTGUN: 'MOD_SHOTGUN',
      MOD_GAUNTLET: 'MOD_GAUNTLET',
      MOD_MACHINEGUN: 'MOD_MACHINEGUN',
      MOD_GRENADE: 'MOD_GRENADE',
      MOD_GRENADE_SPLASH: 'MOD_GRENADE_SPLASH',
      MOD_ROCKET: 'MOD_ROCKET',
      MOD_ROCKET_SPLASH: 'MOD_ROCKET_SPLASH',
      MOD_PLASMA: 'MOD_PLASMA',
      MOD_PLASMA_SPLASH: 'MOD_PLASMA_SPLASH',
      MOD_RAILGUN: 'MOD_RAILGUN',
      MOD_LIGHTNING: 'MOD_LIGHTNING',
      MOD_BFG: 'MOD_BFG',
      MOD_BFG_SPLASH: 'MOD_BFG_SPLASH',
      MOD_WATER: 'MOD_WATER',
      MOD_SLIME: 'MOD_SLIME',
      MOD_LAVA: 'MOD_LAVA',
      MOD_CRUSH: 'MOD_CRUSH',
      MOD_TELEFRAG: 'MOD_TELEFRAG',
      MOD_FALLING: 'MOD_FALLING',
      MOD_SUICIDE: 'MOD_SUICIDE',
      MOD_TARGET_LASER: 'MOD_TARGET_LASER',
      MOD_TRIGGER_HURT: 'MOD_TRIGGER_HURT',
      #ifdef MISSIONPACK
      MOD_NAIL: 'MOD_NAIL',
      MOD_CHAINGUN: 'MOD_CHAINGUN',
      MOD_PROXIMITY_MINE: 'MOD_PROXIMITY_MINE',
      MOD_KAMIKAZE: 'MOD_KAMIKAZE',
      MOD_JUICED: 'MOD_JUICED',
      #endif
      MOD_GRAPPLE: 'MOD_GRAPPLE' 
    }
    return h if name_str.nil?
    h[name_str.to_sym]
  end
end
