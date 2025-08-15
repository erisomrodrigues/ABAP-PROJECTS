*&---------------------------------------------------------------------*
*& Report Z_FIBONACCI_ERI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_fibonacci_eri.

CONSTANTS max_count TYPE i VALUE 20.
DATA numbers TYPE TABLE OF i.
DATA(counter) = 0.
DATA output TYPE TABLE OF string.

DO max_count TIMES.

  CASE sy-index.
    WHEN 1.
      APPEND 0 TO numbers.
    WHEN 2.
      APPEND 1 TO numbers.
    WHEN OTHERS.
      DATA(prev1) = numbers[ sy-index - 2 ].
      DATA(prev2) = numbers[ sy-index - 1 ].
      APPEND ( prev1 + prev2 ) TO numbers.
  ENDCASE.
ENDDO.

LOOP AT numbers INTO DATA(number).
  counter = counter + 1.

  APPEND |{ counter WIDTH = 4 }: { number WIDTH = 10 ALIGN = RIGHT }|
      TO output.
ENDLOOP.

WRITE: / |The first { max_count } Fibonacci Number|.
WRITE:/.

LOOP AT output INTO DATA(line).
  WRITE:/ line.
ENDLOOP.
