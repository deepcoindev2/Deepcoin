#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

DEEPCOIND=${DEEPCOIND:-$BINDIR/deepcoind}
DEEPCOINCLI=${DEEPCOINCLI:-$BINDIR/deepcoin-cli}
DEEPCOINTX=${DEEPCOINTX:-$BINDIR/deepcoin-tx}
DEEPCOINQT=${DEEPCOINQT:-$BINDIR/qt/deepcoin-qt}

[ ! -x $DEEPCOIND ] && echo "$DEEPCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
DPCVER=($($DEEPCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for deepcoind if --version-string is not set,
# but has different outcomes for deepcoin-qt and deepcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$DEEPCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $DEEPCOIND $DEEPCOINCLI $DEEPCOINTX $DEEPCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${DPCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${DPCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
