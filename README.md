# Docker Claude Code

A simple image for isolating Claude Code from the rest of your system.

It's just Ubuntu with Claude Code installed.


## Details

The working directory is `/workdir`.


## Usage

From a project directory, start Claude Code on the container:

```bash
docker run \
  --rm \
  --interactive \
  --tty \
  --volume ${PWD}:/workdir \
  --volume ~/.claude:/root/.claude \
  --volume ~/.claude.json:/root/.claude.json \
  ghcr.io/mfisher87/claude-code \
  claude
```

The 2nd and 3rd volume mounts above will mount your local Claude Code config into your
container, so you won't need to login or reconfigure anything.
An alternative is to use named volumes to persist Claude Code config for the container
_separately_ from your local Claude Code config.


### Note on passing in credentials

This method may not work on all operating systems.
I've only tested it on Linux (Ubuntu 24 derivative) ;)

See: <https://github.com/anthropics/claude-code/issues/10039>
