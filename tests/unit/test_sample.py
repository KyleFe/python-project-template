"""Sample unit test."""
from {{ package_name }} import __version__


def test_version() -> None:
    """Test package version is set."""
    assert __version__ == "0.1.0"
