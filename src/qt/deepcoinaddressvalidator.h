// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef DEEPCOIN_QT_DEEPCOINADDRESSVALIDATOR_H
#define DEEPCOIN_QT_DEEPCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class DeepcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit DeepcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Deepcoin address widget validator, checks for a valid deepcoin address.
 */
class DeepcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit DeepcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // DEEPCOIN_QT_DEEPCOINADDRESSVALIDATOR_H
