import os
import logging
import pandas as pd


def main() -> None:
    # Simple structured logging (better for containers than print)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s",
    )

    # Configuration via environment variable
    name = os.getenv("NAME", "World")

    # Small dataset for the sample application
    df = pd.DataFrame(
        {
            "Name": ["Pierre", "Paul", "Marie"],
            "Age": [22, 35, 58],
        }
    )

    logging.info("Hello %s, I'm Python running inside a container!", name)
    logging.info("Here is your DataFrame:\n%s", df)


if __name__ == "__main__":
    main()
