grammar IP2;
start: Host EOF ;

Host : FirstPart Octet Dot Octet ;

FirstPart :
///do not start in 10.
    |   ([0-9]) Dot Octet Dot
    |   ('1'[1-9]) Dot Octet Dot |   ('1'[0-6][0-9]) Dot Octet Dot |   ('1''7'[0-1]) Dot Octet Dot
    |   ([2-9][0-9]) Dot Octet Dot
///do not start in 172.16 - 172.31
    |   ('172.' [0-9]  ) Dot
    |   ('172.1' [0-5]  ) Dot
    |   ('172.3' [2-9]  )Dot
    |   ('172.' [4-9][0-9]  ) Dot
    |   ('172.1' [0-9][0-9]  ) Dot
    |   ('172.2'[0-4][0-9]) Dot
    |   ('172.2''5'[0-5] ) Dot
    |   ('1''7'[3-9]) Dot Octet Dot
    |   ('18'[0-9]) Dot Octet Dot
    |   ('19'[0-1]) Dot Octet Dot
///do not start in 192.168
    |   ('192.'[0-9]?[0-9] ) Dot
    |   ('192.1'[0-5][0-9]) Dot
    |   ('192.16'[0-7]) Dot
    |   ('192.169') Dot
    |   ('192.1'[7-9][0-9]) Dot
    |   ('192.2'[0-4][0-9] ) Dot
    |   ('192.25'[0-5] ) Dot
    |   ('19'[3-9]) Dot Octet Dot
    |   ('2'[0-4][0-9]) Dot Octet Dot
    |   ('2''5'[0-5] ) Dot Octet Dot
    ;

Octet : ([0-9]?[0-9])
        | ('1'[0-9][0-9] )
        | ('2'[0-4][0-9])
        | ('2''5'[0-5])
       ;

 Dot : '.' ;

