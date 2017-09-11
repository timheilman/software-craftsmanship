# LC_ALL=en_US.UTF-8 awk -f format.awk -F'|' i.psv
# Code Smell|Subsmell|Addressing Refactorings

function emitListOfSubsmellsNote(codeSmell) {
    printf("Beck/Fowler code smell: %s. Subsmells: {{c1::", codeSmell)
    firstRecord = 1
    for (subsmell in subsmells) {
	if (!firstRecord) {
	    printf(", ")
	}
	printf("%s", subsmell)
	firstRecord = 0
    }
    printf("}}\tRefactoring\t3\t\n")
}

function emitSubsmellSolutionsNotes(codeSmell) {
    for (subsmell in subsmells) {
	printf("Beck/Fowler code smell: %s. Subsmell: {{c1::%s}} Consider: {{c2::%s}}\tRefactoring\t3\t\n", codeSmell, subsmell, subsmells[subsmell])
    }
}

function processCodeSmell(codeSmell) {
#    print "processing", lastSmell
    emitListOfSubsmellsNote(codeSmell)
    emitSubsmellSolutionsNotes(codeSmell)
    delete subsmells
}

BEGIN {
    lastSmell = ""
}
{
    if ($0 ~ /^\s*$/) next
#    print "start record"
    if (lastSmell != $1 && lastSmell != "") {
#	print "Found New Smell"
	processCodeSmell(lastSmell)
    }
    subsmells[$2] = $3
    lastSmell = $1
#    print "end record"
}
END {
#    print "at END"
    processCodeSmell(lastSmell)
#    print "done with END"
}	 
