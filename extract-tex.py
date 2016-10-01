#!/usr/bin/python
"""
Henrison Hsieh's personal script for extracting citekeys and gloss abbreviations
used in LaTeX source files for papers
"""
import re
import argparse

def extract(f, regexp, splitr, verbose):
    """
    Take a file `f` and extract the contents of all commands matching `re`,
    split by tokens matching `split`. Returns a list.
    """
    hits = [] # Return a list, set union handled separately
    if verbose: print "  Matches for pattern:", regexp.pattern
    for line in f:
        for match in regexp.finditer(line):
            if match:
                if verbose: print "    ", match.group(0)
                hits.extend(splitr.split(match.group(1)))
    return hits

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract glosses or citations from a tex file")
    parser.add_argument("-g", "--gloss-only", action="store_true",
                        help="Suppress citation extraction")
    parser.add_argument("-c", "--citation-only", action="store_true",
                        help="Suppress gloss extraction")
    parser.add_argument("-s", "--no-split", action="store_true",
                        help="Suppress splitting; potentially useful"
                             "for debugging")
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("files", nargs="+", help="Files to parse")

    args = parser.parse_args()
    get_gloss = not args.citation_only
    get_citation = not args.gloss_only
    split = not args.no_split

    glosses = set()
    # Find things that are in \g{...} or \gix{...}.
    # Will get tripped up by \g{...\ix{...}...} or other nesting
    gloss_re = re.compile(r"\\g(?:ix)?\{([^}]+)\}")
    # Splits compound glosses by the connectors from the Leipzig conventions
    gloss_split = re.compile(r"[.=-]|\\ix\{|\\\*" if split else "")

    citations = set()
    # Match all cite commands except \citetext
    citations_re = re.compile(r"\\cite(?!text)(?:[^{]*)\{([^}]*)\}")
    citations_split = re.compile(r"," if split else "")

    for name in args.files:
        print "Opening file", name
        with open(name, "r") as f:
            if get_gloss:
                glosses = glosses.union(extract(f, gloss_re, gloss_split, args.verbose))
                f.seek(0) # Reset to beginning for the next part
            if get_citation:
                citations = citations.union(extract(f, citations_re, citations_split, args.verbose))
        if args.verbose: print


    if get_gloss:
        print "\nGLOSSES (Total {})".format(len(glosses))
        for gloss in sorted(list(glosses)): print gloss
    if get_citation:
        print "\nCITATIONS (Total {})".format(len(citations))
        for cite in sorted(list(citations)): print cite
    print "\nDone!"
