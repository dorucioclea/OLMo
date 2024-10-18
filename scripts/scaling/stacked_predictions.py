import argparse
import json

import numpy as np

from olmo.scaling.scaling_laws.stacked_predictions import (
    DownstreamPredictionFeatures,
    get_downstream_predictions,
)
from olmo.scaling.scaling_laws.utils import FinalConfig

# We only include ce loss and the 6 dolma sets, as these are the sets we can include in the paper
ce_columns = [
    "eval/c4_en-validation/CrossEntropyLoss",
    "eval/dolma_books-validation/CrossEntropyLoss",
    "eval/dolma_common-crawl-validation/CrossEntropyLoss",
    "eval/dolma_pes2o-validation/CrossEntropyLoss",
    "eval/dolma_reddit-validation/CrossEntropyLoss",
    "eval/dolma_stack-validation/CrossEntropyLoss",
    "eval/dolma_wiki-validation/CrossEntropyLoss",
]

mmlu_names = ["mmlu_stem", "mmlu_humanities", "mmlu_social_sciences", "mmlu_other"]

main_tasks = ["hellaswag", "arc_easy", "arc_challenge", "piqa", "openbookqa", "csqa", "socialiqa"]

baselines_rc_5shot = {
    "piqa": 0.5,
    "socialiqa": 1 / 3,
    "csqa": 0.2,
}

baselines_mc_5shot = {
    "piqa": 0.5,
    "socialiqa": 1 / 3,
    "csqa": 0.2,
}

tasks_rc_5shot = {
    f"{key}_rc_5shot": {
        "bpb": [f"eval/downstream_bpb/{key}_rc_5shot_bpb_bpb"],
        "score": [f"eval/downstream/{key}_rc_5shot_len_norm" if key not in ["arc_easy"] else f"eval/downstream/{key}_rc_5shot_acc"],
        "baseline": baselines_rc_5shot.get(key, 0.25),
    }
    for key in main_tasks
}

tasks_mmlu_var = {
    f"{key}_var": {
        "bpb": [f"eval/downstream_bpb/{key}_var_bpb_bpb"],
        "score": [f"eval/downstream/{key}_var_len_norm"],
        "baseline": 0.25,
    }
    for key in mmlu_names
}

tasks = {**tasks_rc_5shot, **tasks_mmlu_var}


def prettify(rel_error):
    return f"{rel_error * 100:+.1f}%"


def make_parser():
    parser = argparse.ArgumentParser(
        description="Get downstream predictions for a target model, based on model ladder outputs."
    )
    # TODO: Give an example.

    parser.add_argument("config_path", help="Path to config specifying the input and target model runs.")

    parser.add_argument(
        "--save_figures",
        type=str,
        help="Use this to specify a png path for saving the plots for fitted curves. If not specified, plots will not be created",
        default=None,
    )

    parser.add_argument(
        "--use_last_n_percentage",
        type=float,
        default=1.0,
        help="Optionally limit the number of training points to last n percentage",
    )

    parser.add_argument(
        "--feature_type",
        type=str,
        default=DownstreamPredictionFeatures.raw,
        help="{raw, moving_average, exponential_moving_average}",
    )

    parser.add_argument("--feature_kwargs", type=str, default="{}", help="Eg. {'window': 20}")

    return parser


def main():
    parser = make_parser()
    args = parser.parse_args()

    # if args.save_figures is not None:
    #     os.makedirs(args.save_figures, exist_ok=True)

    with open(args.config_path) as f:
        configs = json.load(f)
    configs = {name: FinalConfig(**config) for name, config in configs.items()}

    feature_kwargs = json.loads(args.feature_kwargs)

    step1_error, stacked_error = get_downstream_predictions(
        configs,
        tasks,
        args.feature_type,
        args.use_last_n_percentage,
        save_figures=args.save_figures,
        **feature_kwargs,
    )

    mkdn = """| Task | Step1 error | Stacked error |\n| --- | --- |"""

    for task in tasks:
        mkdn += f"\n| {task} |"
        for target in stacked_error:
            mkdn += f"{prettify(step1_error[target][task])} | {prettify(stacked_error[target][task])} |"

    mkdn += "\n| **Avg signed error** | "
    for target in stacked_error:
        mkdn += f"**{prettify(np.mean(list(step1_error[target].values())))}** | **{prettify(np.mean(list(stacked_error[target].values())))}** |"

    mkdn += "\n| **Avg unsigned error** | "
    for target in stacked_error:
        mkdn += f"**{prettify(np.mean(np.abs(list(step1_error[target].values()))))}** | **{prettify(np.mean(np.abs(list(stacked_error[target].values()))))}** |"
    print(mkdn)


if __name__ == "__main__":
    main()
