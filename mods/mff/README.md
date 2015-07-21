* MFF-specific mods folder

** Code convention
All MFF mods must be in the `mff` global table, and thus shall depend on the mff_core mod first defining it.
The reason for this is to allow introspection using mff_introspect to track bugs at runtime, and more generally to define a code namespace.
