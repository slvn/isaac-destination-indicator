// Register the mod
// (which will make it show up in the list of mods on the mod screen in the main menu)
const mod = RegisterMod("isaacDestinationIndicator", 1);

const SPRITE_MOM_FOOT = 0;
const SPRITE_MOM_HEART = 1;
const SPRITE_SATAN = 2;
const SPRITE_ISAAC = 3;
const SPRITE_THE_LAMB = 4;
const SPRITE_BLUE_BABY = 5;
const SPRITE_MEGA_SATAN = 6;
const SPRITE_HUSH = 8;
const SPRITE_DELIRIUM = 9;
const SPRITE_MOTHER = 10;
const SPRITE_THE_BEAST = 11;
const SPRITE_EMPTY = 12;

const RANDOM = [
  SPRITE_MOM_FOOT,
  SPRITE_MOM_HEART,
  SPRITE_SATAN,
  SPRITE_ISAAC,
  SPRITE_THE_LAMB,
  SPRITE_BLUE_BABY,
  SPRITE_MEGA_SATAN,
  SPRITE_HUSH,
  SPRITE_DELIRIUM,
  SPRITE_MOTHER,
  SPRITE_THE_BEAST,
];

const sprite = Sprite();
const base = Vector(20, 73);

const hudOffset = 0;

let destination = SPRITE_EMPTY;

// Define callback functions
function postGameStarted() {
  sprite.Load("gfx/ui/hudpickups2.anm2", true);
  const seed = Game().GetSeeds().GetStartSeed();
  Isaac.DebugString(`isaac-destination-indicator using seed: ${seed}`);
  math.randomseed(seed);
}

function inputAction(
  _entity: Entity | undefined,
  _inputHook: InputHook,
  _buttonAction: ButtonAction,
): number | boolean | void {
  if (
    Input.IsButtonPressed(Keyboard.KEY_LEFT_SHIFT, 0) ||
    Input.IsButtonPressed(Keyboard.KEY_RIGHT_SHIFT, 0)
  ) {
    if (Game().IsPaused()) return;

    if (Input.IsButtonTriggered(Keyboard.KEY_1, 0)) {
      destination = SPRITE_BLUE_BABY;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_2, 0)) {
      destination = SPRITE_THE_LAMB;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_3, 0)) {
      destination = SPRITE_MOTHER;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_4, 0)) {
      destination = SPRITE_THE_BEAST;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_5, 0)) {
      destination = SPRITE_MEGA_SATAN;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_6, 0)) {
      destination = SPRITE_HUSH;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_7, 0)) {
      destination = SPRITE_DELIRIUM;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_8, 0)) {
      destination = SPRITE_SATAN;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_9, 0)) {
      destination = SPRITE_ISAAC;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_0, 0)) {
      destination = SPRITE_EMPTY;
    } else if (Input.IsButtonTriggered(Keyboard.KEY_GRAVE_ACCENT, 0)) {
      destination = RANDOM[Random() % RANDOM.length];
    } else if (Input.IsButtonTriggered(Keyboard.KEY_BACKSPACE, 0)) {
      destination = RANDOM[Random() % RANDOM.length];
    } else {
      return;
    }
    sprite.SetFrame("Destination", destination);
    return false;
  }
  return;
}

function postRender() {
  const offset = getOffset();

  const x = base.X + 2 * offset;
  const y = base.Y + 1.2 * offset + characterYOffset();

  sprite.Render(Vector(x, y), Vector(0, 0), Vector(0, 0));
}

function getOffset() {
  return Options.HUDOffset * 10;
}

function characterYOffset(): int {
  switch (Isaac.GetPlayer()?.GetPlayerType()) {
    case PlayerType.PLAYER_JACOB:
      return 13;
    case PlayerType.PLAYER_BETHANY:
    case PlayerType.PLAYER_BETHANY_B:
      return 8;
    default:
      return 0;
  }
}

// Register callbacks
mod.AddCallback(ModCallbacks.MC_POST_GAME_STARTED, postGameStarted);
mod.AddCallback(ModCallbacks.MC_POST_RENDER, postRender);
mod.AddCallback(
  ModCallbacks.MC_INPUT_ACTION,
  inputAction,
  InputHook.IS_ACTION_PRESSED,
);

// Print an initialization message to the "log.txt" file
Isaac.DebugString("isaac-destination-indicator initialized.");
