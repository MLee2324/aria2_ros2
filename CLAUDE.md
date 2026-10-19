# Project conventions

## Code style

Code reads like [PyDreamerV1](https://github.com/minhphd/PyDreamerV1): plain, short, and named after the method it
implements.

- Keep code clean and easy to modify. Plain loops, preallocated arrays and boolean arrays over bit masks, index
  arithmetic and dense one-liners.
- One class per part of the method, its methods the stages, named in plain CS terms rather than math symbols:
  `ParticleFilter.observe_clip`, `ChoiceModel.weights` (in PyDreamerV1, `RSSM.recurrent`, `Dreamer.dynamic_learning`).
- Descriptive names (`posterior`, `progress`, `done_probs`); single letters only for indices and shape sizes.
- Google-style docstrings with Args and Returns, every array with its shape: `current (K, M): the subgoal each
  particle is on, -1 for none`. The module docstring names the shape letters once.
- Keep comments to two lines or fewer, except docstrings. No author, Created or Last Modified headers.
- Every setting of a run lives in one YAML file in `configs/`, never in Python constants or dataclasses. A script
  takes `--config configs/<name>.yml` and `key=value` overrides (`helper/config.py`, a frozen addict Dict), passes each
  class its block (`ChoiceModel(cfg.choice, ...)`), saves the config beside its results and never overwrites a
  finished run.
- Prefer small, focused interfaces so policies, environments, and visualization code can evolve independently.
  Environments follow the Gymnasium API; whatever decides (the person, the robot) subclasses one `Agent`.
- Short files, one concern each. Research code in `src/`, reusable tools in `helper/`.
- PyTorch for learned models, numpy for the rest; no JAX.
- A README says what the package is, its layout, and numbered steps to run it with a config and find the results.


## Writing style (deck, docs, figure labels)

- Declarative, timeless prose. No development history, no "we found".
- No em dashes anywhere. One symbol, one meaning across text and figures.
- Keep docs short and plain.
