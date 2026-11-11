set -o pipefail

re='([0-9a-zA-Z][0-9]{8})'
re+='&([0-9]{3}[\x09-\x0d\x20\x2d]?[0-9]{2}[\x09-\x0d\x20\x2d]?[0-9]{4})'
re+='&(([0-9]{3}[\x09-\x0d\x20]){2}[0-9]{3})'
re+='&[0-9]{6}'
re+='&(9[0-9]{2}[\x09-\x0d\x20\x2d]?((5[0-9])|(6[0-5])|(7[0-9])|(8[0-8])|(9([0-2]|[4-9])))[\x09-\x0d\x20\x2d]?[0-9]{4})'

printf '%s\n' "$re" \
  | regex/bin/TestRegex E

printf '%s\n' "$re" \
  | regex/bin/TestRegex F \
  | sed -n '/^const u32 STR_LENGTH/,$p' \
  > circ/zkmb/dlp_policy.zok.tmp \
  && test -s circ/zkmb/dlp_policy.zok.tmp \
  && mv circ/zkmb/dlp_policy.zok.tmp circ/zkmb/dlp_policy.zok
