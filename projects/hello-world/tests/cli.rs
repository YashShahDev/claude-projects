use std::process::Command;

// Exercises the compiled binary directly, not the private greeting() helper,
// so this catches regressions the unit test can't: wrong stream, missing
// newline, non-zero exit, or main() no longer calling greeting() at all.
#[test]
fn prints_hello_world_to_stdout() {
    let output = Command::new(env!("CARGO_BIN_EXE_hello-world"))
        .output()
        .expect("failed to run the hello-world binary");

    assert!(output.status.success());
    assert_eq!(output.stdout, b"Hello, world!\n");
    assert!(output.stderr.is_empty());
}
