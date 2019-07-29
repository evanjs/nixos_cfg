# Personal Overlay

## TODO
- Provide a way for Rust components to fail gracefully
  - Example: Attempt to install clippy with base components.
    If clippy fails, try to install std and src.
    If src is unavailable, try to install std, etc.
  - Provide a means of selecting a package in the overlay _only_ if it is newer than what is available on nixpkgs
    If there is an equivalent or newer version available on nixpkgs, use that instead

