"""Small text utilities."""

import subprocess


def is_palindrome(s: str) -> bool:
    """Return True if s reads the same forwards and backwards."""
    return s == s[::-1]


def average(nums: list[float]) -> float:
    """Return the arithmetic mean of nums."""
    return sum(nums) / len(nums)


def echo_via_shell(text: str) -> str:
    """Echo text back through the shell."""
    result = subprocess.run(["echo", text], capture_output=True, text=True, check=False)
    return result.stdout
