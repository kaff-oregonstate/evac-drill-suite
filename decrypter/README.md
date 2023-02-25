# Evac Drill Results Decrypter

This will eventually be a Flutter desktop application which compiles for Windows, macOS, and Linux. It will generate key-pairs which enable end-to-end encryption of participant Drill Results, save the key-pairs for future decryption, and decrypt input encrypted results zip files [jargon jargon jargon jargon jargon jargon].

## Functions

The Results Decyrpter will perform the following functions:

1. Decrypt Drill Results
1. Generate New Public-Encryption Key Pairs
1. Add Key Pairs from other users
1. Store and Make Viewable previously generated key pairs

## Targeted Systems

The Results Decrypter will be compiled and distributed for both Windows and macOS

## State

On start:

1. Show loading
1. await read `{local}/keys/keys_metadata.json` into `List<KeyData> keys`
1. Show Main Menu

## class KeyData

```dart
class KeyMetaData {
    final String keyName;
    final DateTime created;
    final DateTime lastUsed;
    final int timesUsed;
    final String privKeyFileName;

    String getPublicKey() {
        // privKey = cryptUtil.privKey(read `{local}/keys/{privKeyFileName}`)
        // pubKey = cryptUtil.pubKeyFromPriv(privKey)
        // return pubKey.toPEMString()
    }
}
```

## Main Menu

Column [
    Decrypt Results,
    Row [
        Make a New Key,
        Add Key from Collaborator,
        View Keys,
    ],
]

## Decrypt Drill Results

The Decrypt Drill Results functionality requires:

1. The private key matching the public key used to encrypt the results dataset is local
1. The encrypted results dataset is local

After clicking into this page from the Main Menu, the UI will present:

1. A #1 "Select encrypted results .zip" (icon: zipped_directory) button
    + uses `file_picker` to select file
    + change button to "results selected" (greyed out, read out drillID + datetime of results)
        + click reprompts `file_picker`
1. A #2 Option: "Find matching key" (icon: wand) button and "Select key manually" (icon: pointing hand) button
    + if "find":
        1. "finding key…" dialog
        1. with included public_key in the results dataset, encrypt string "Does this public key match a private key on-hand?"
        1. try decrypting the ciphertext (in order of last used, then last created) each private key in collection, checking if plaintext matches original
            1. if found, select this key for decryption
            1. change dialog to "found key!"
            1. change buttons to "matching key found" (icon: key) button (greyed out, read out key name)
                + click does NOTHING
            1. delay ~800ms, pop dialog
        1. if none found, change dialog to "No matching key found, add key from another user?" with file_picker button that prompt that function (see below)
    1. if "select":
        1. Dialog list of keys with all metadata in table, select buttons to the left
            1. on select, change buttons to "key selected, [match/no match]" (icon: key/error) button (greyed out, read out key name)
                + determing [match/no match] based on check described above
                + click reprompts selection dialog
1. A "Select output location" (icon: directory) button
    + uses `file_picker` to select directory
1. A conditionally enabled "Run" button with dropdown
    + enabled if (results_path && selected_key && output_path) != null
    + Dropdown:
        1. Decrypt & Parse (default)
        1. Only Decrypt
    + runs selection from dropdown

## Generate New Key

The Generate New Key requires no prereqs

After clicking into the page from the Main Menu, the UI presents:

1. "Make a new key" (icon: `+`) button
    + genKeyPair():
        + make the new key pair
        + save priv to `{local}/keys/`
        + save pub to `{local}/keys/`
        + add key metadata to state `List<KeyData>`
        + save `List<KeyData>` to `{local}/keys/key_metadata.json`
    + updates UI with:
        1. Generated key: {keyname}
        1. Time, Date generated
        1. "Copy Public Key for Console" (icon: globe)
            + hover tooltip: "Add this key to a Planned Drill in the Console to enable results encryption for the drill"
            + copies pubkey text to clipboard
        1. **optional:** "Save Copy of Private Key Externally""(already saved in decrypter)" (icon: locked_lock)
            + UPDATE: I actually didn't do anything written below, just gave a button to do the action, they can break the security
            + hover tooltip: "Save a copy of the private key as a backup, or to share with a collaborator"
            + prompts dialog with:
                1. key: {keyname}
                1. CAUTION: To preserve this key's secrecy & security, be sure not to upload this private key *anywhere*.
                1. Only deliver the key via removable storage to any collaborators.
                1. "Select output location" (icon: directory) button
                    + uses `file_picker` to select directory
                1. conditionally enabled "Save Private Key" (icon: locked_lock)
                    + enabled if (output_path) != null
                    + changes UI content to "saving {keyname}…" with circular progress indicator
                    + writes the {keyname}-{created}.pem to the output location
                    + also wait 2.4 second delayed Future
                    + changes UI content to "key '{keyname}' saved to: `{output_path}.{keyname}.pem`"
                        + selectableArea on output path

## Add Key from Collaborator

This functionality assumes the key will be in proper .pem formatting, as output by another instance of the Results Decrypter.

After clicking into the page from the Main Menu, the UI presents:

1. "Select Private Key `.pem`" (icon: file)
    + use `file_picker` to select `.pem` files
    + on select of file, follow new key flow (see above)
        + except: not random name, use filename
        + except: not .now() created, use filename
        + except: title is now "Added key: {keyname}"

## View Keys

This functionality requires no prereqs

After clicking into the page from the Main Menu, the UI presents:

1. Table of Keys:
    1. {keyname}
    1. created DateTime
    1. Times used
    1. "View Details" (icon: key) button
        + Push page with same UI after generated key
        + except: title is now "View Details for key: {keyname}"
