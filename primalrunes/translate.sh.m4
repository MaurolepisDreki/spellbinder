m4_dnl translator deffinitions: m4 to shell
m4_define([ASSIGN],[[$1]="$2"])m4_dnl
m4_define([EXPORT],[ASSIGN([$1],[$1])])m4_dnl
m4_dnl
m4_define([SET_PROJECT_NAME],[m4_define([PROJECT_NAME],[$1])EXPORT([PROJECT_NAME])])m4_dnl
m4_define([SET_PROJECT_VERSION],[m4_dnl
m4_ifelse(m4_eval($# >= 1),m4_true,[m4_define([PROJECT_VERSION_MAJOR],[$1])EXPORT([PROJECT_VERSION_MAJOR])
m4_ifelse(m4_eval($# >= 2),m4_true,[m4_define([PROJECT_VERSION_MINOR],[$2])EXPORT([PROJECT_VERSION_MINOR])
m4_ifelse(m4_eval($# >= 3),m4_true,[m4_define([PROJECT_VERSION_PATCH],[$3])EXPORT([PROJECT_VERSION_PATCH])
m4_ifelse(m4_eval($# >= 4),m4_true,[m4_define([PROJECT_VERSION_TWEAK],[$4])EXPORT([PROJECT_VERSION_TWEAK])])])])])
m4_define([PROJECT_VERSION],[m4_ifdef([PROJECT_VERSION_MAJOR],[V]PROJECT_VERSION_MAJOR)]m4_ifdef([PROJECT_VERSION_MINOR],[.]PROJECT_VERSION_MINOR)[m4_ifdef([PROJECT_VERSION_PATCH],[ V]PROJECT_VERSION_PATCH)]m4_ifdef([PROJECT_VERSION_TWEAK],[-]PROJECT_VERSION_TWEAK))EXPORT([PROJECT_VERSION])
])m4_dnl
