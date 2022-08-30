grammar C;
start:Corect  EOF;
Corect:Word Reapete Word;
Reapete:'bbb';
Alphabet: 'a'|'b'|'c';
Word: Alphabet *;