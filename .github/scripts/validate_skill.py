from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]


def main() -> None:
    skill = ROOT / "SKILL.md"
    metadata = ROOT / "agents" / "openai.yaml"

    if not skill.exists():
        raise SystemExit("Missing SKILL.md")
    if not metadata.exists():
        raise SystemExit("Missing agents/openai.yaml")

    data = yaml.safe_load(metadata.read_text())
    if not isinstance(data, dict):
        raise SystemExit("agents/openai.yaml must parse to a mapping")

    interface = data.get("interface")
    if not isinstance(interface, dict):
        raise SystemExit("agents/openai.yaml must contain an interface mapping")

    required = ["display_name", "short_description", "default_prompt"]
    missing = [key for key in required if not interface.get(key)]
    if missing:
        raise SystemExit(
            f"Missing required interface keys: {', '.join(missing)}"
        )

    script_dir = ROOT / "scripts"
    if not script_dir.exists():
        raise SystemExit("Missing scripts directory")

    print("Skill validation passed")


if __name__ == "__main__":
    main()
