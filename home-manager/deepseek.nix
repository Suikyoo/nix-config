# DeepSeek as the Claude Code backend. Enable by uncommenting ./deepseek.nix in home.nix.
#
# ANTHROPIC_AUTH_TOKEN must never be added to home.sessionVariables below. Those values are
# evaluated at build time and written verbatim into /nix/store/.../hm-session-vars.sh, which
# is world-readable — so a key placed there is visible to every user and process on the
# machine, and gets committed to this repo (which is pushed to GitHub). A key previously in
# this file had to be scrubbed from the store with `nix-collect-garbage -d`.
#
# The key is read at runtime instead, from the gitignored home-manager/.env, by the
# profileExtra below. Only the *path* ends up in the store. Being gitignored also keeps the
# file out of the store for a second reason: flake evaluation copies only git-tracked files.
#
# `programs.bash.profileExtra` is appended to ~/.profile, where home-manager already sources
# hm-session-vars.sh, so the key is inherited by a login session exactly like the declarative
# variables. Deliberately NOT `initExtra`: ~/.bashrc starts with `[[ $- == *i* ]] || return`,
# so an initExtra hook would never reach scripts, ssh commands or editor subprocesses.
#
# The path below is a Nix *string*, not a path literal — `./.env` would ask Nix to copy the
# file into the store and defeat the entire point.
#
# .env format: one KEY=value per line; `export` is not needed, `set -a` handles it. Sourced
# as shell, so quote values containing spaces and remember `#` starts a comment.
#
# Both halves are gated on this module being imported: while ./deepseek.nix is commented out
# in home.nix, the .env is not read at all. Editing .env needs no rebuild, just a new login
# session; `home-manager switch` is only required when changing this file.
{ config, ... }:
let
  envFile = "${config.home.homeDirectory}/nix/home-manager/.env";
in
{
  home.sessionVariables = {
    ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic";
    ANTHROPIC_MODEL = "deepseek-flash[1m]";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-flash[1m]";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-flash[1m]";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-flash";
    CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-flash";
    CLAUDE_CODE_EFFORT_LEVEL = "max";
    CLAUDE_CODE_AUTO_COMPACT_WINDOW = "786432";
  };

  programs.bash.profileExtra = ''
    # Export everything in the gitignored .env (ANTHROPIC_AUTH_TOKEN), when present.
    # allexport is saved and restored so the setting cannot leak into the rest of the profile.
    if [ -r "${envFile}" ]; then
      __hm_allexport="$(set +o | grep allexport)"
      set -a
      . "${envFile}"
      set +a
      eval "$__hm_allexport"
      unset __hm_allexport
    fi
  '';
}
