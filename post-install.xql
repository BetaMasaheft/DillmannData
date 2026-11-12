xquery version "3.1";

import module namespace sm = "http://exist-db.org/xquery/securitymanager";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";

(: The following external variables are set by the repo:deploy function :)
declare variable $home external;
declare variable $dir external;
declare variable $target external;

(:
 : The Dillmann app (gez-en) stores newly created lemmas in $target/new as the
 : logged-in editor. Members of the "lexicon" group must therefore be able to
 : write to that collection, and the app then chgrps each new file to "lexicon".
 :)
let $new := $target || "/new"
let $_group := if (sm:group-exists("lexicon")) then () else sm:create-group("lexicon")
let $_coll := if (xmldb:collection-available($new)) then () else xmldb:create-collection($target, "new")
return (
  sm:chgrp(xs:anyURI($new), "lexicon"),
  sm:chmod(xs:anyURI($new), "rwxrwxr-x")
)
