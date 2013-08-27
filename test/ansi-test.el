(ert-deftest test-nesting ()
  (let ((actual (ansi-bold (ansi-red (ansi-blink "string"))))
        (expected "\e[1m\e[31m\e[5mstring\e[0m\e[0m\e[0m"))
    (should (equal actual expected))))

(ert-deftest test-nesting-in-dsl ()
  (let ((actual (with-ansi (bold (red (blink "string")))))
        (expected "\e[1m\e[31m\e[5mstring\e[0m\e[0m\e[0m"))
    (should (equal actual expected))))

(ert-deftest test-ansi-concat ()
  (should (equal (ansi--concat "a" "b" "c") "abc"))
  (should (equal (ansi--concat "a" nil "c") "ac"))
  (should (equal (ansi--concat "a" 1 "c")   "ac")))

(ert-deftest test-with-ansi-can-handle-different-return-values ()
  (with-ansi "")
  (with-ansi nil)
  (with-ansi 0)
  (with-ansi '(a)))

(ert-deftest test-ansi-apply-effect ()
  (should (equal (ansi-black "foo %s" "bar")
                 (ansi-apply 'black "foo %s" "bar")))
  (should (equal (ansi-on-black "foo %s" "bar")
                 (ansi-apply 'on-black "foo %s" "bar")))
  (should (equal (ansi-bold "foo %s" "bar")
                 (ansi-apply 'bold "foo %s" "bar"))))

(ert-deftest test-ansi-apply-code ()
  (should (equal (ansi-black "foo %s" "bar")
                 (ansi-apply 30 "foo %s" "bar")))
  (should (equal (ansi-on-black "foo %s" "bar")
                 (ansi-apply 40 "foo %s" "bar")))
  (should (equal (ansi-bold "foo %s" "bar")
                 (ansi-apply 1 "foo %s" "bar"))))
