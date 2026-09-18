from text_tools import average, echo_via_shell, is_palindrome


def test_is_palindrome_empty():
    assert is_palindrome("") is True


def test_is_palindrome_two_char_non_palindrome():
    assert is_palindrome("ab") is False


def test_average_typical():
    assert average([1, 2, 3]) == 2


def test_echo_via_shell_basic():
    assert echo_via_shell("hello").strip() == "hello"
