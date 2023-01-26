import React, { ReactElement, useContext, useEffect, useState } from "react";
import CodeBlock from "@theme/CodeBlock";

const SKIP = "/* SKIP */";
const SKIP_END = "/* SKIP END */";
const START_AT = "/* SNIPPET START */";
const END_AT = "/* SNIPPET END */";

const SNIPPET_START = "/* SNIPPET START */";
const SNIPPET_END = "/* SNIPPET END */";

// create a regexp that finds the text in between /* SNIP FOO */ and /* SNIP FOO END */;
// but not including the /* SNIP FOO */ and /* SNIP FOO END */ lines
const SNIP_CONTENT_REGEXP = /\/\* SNIP (\w+) \*\/([\s\S]*?)\/\* SNIP \1 END \*\//g

// a regexp that finds all text thats not in between /* SKIP FOO */ and /* SKIP FOO END */;
// but not including the /* SKIP FOO */ and /* SKIP FOO END */ lines
const SKIP_CONTENT_REGEXP = /(?:\/\* SKIP \w+ \*\/[\s\S]*?\/\* SKIP \w+ END \*\/)|(?:[\s\S]*?)/g


export function generateSnippet(contents: string, snippets: string[]): string {
  let matches: RegExpExecArray | null;
  let matchedString = '';
  while ((matches = SNIP_CONTENT_REGEXP.exec(contents)) !== null) {
    console.log(matches[1]);
    if (snippets.includes(matches[1])) {
      matchedString += matches[2] + ' ';
    }
  }
  return matchedString;
}


// export function generateSnippet(contents: string, snippets: Array<string>): string {
//   const startAtIndex = contents.indexOf(START_AT);
//   if (startAtIndex < 0) return contents;

//   let endAtIndex = contents.indexOf(END_AT);
//   if (endAtIndex < 0) endAtIndex = undefined;

//   contents = contents
//     .substring(startAtIndex + START_AT.length, endAtIndex)
//     .trim();

//   return contents.replace(
//     /\n?(?:\/\* SNIP \*\/)(?:\n|.)+(?:\/\* SKIP END \*\/)/,
//     ""
//   );
// }

export function trimSnippet(snippet: string): string {
  const startAtIndex = snippet.indexOf(START_AT);
  if (startAtIndex < 0) return snippet;

  let endAtIndex = snippet.indexOf(END_AT);
  if (endAtIndex < 0) endAtIndex = undefined;

  snippet = snippet
    .substring(startAtIndex + START_AT.length, endAtIndex)
    .trim();

  return snippet.replace(
    /\n?(?:\/\* SKIP \*\/)(?:\n|.)+(?:\/\* SKIP END \*\/)/,
    ""
  );
}

interface CodeSnippetProps {
  title?: string;
  snippet: string;
}

export const CodeSnippet: React.FC<CodeSnippetProps> = ({ snippet, title, ...other }) => {
  return (
    <div className={`snippet`}>
      <div className="snippet__title_bar">
        <div className="snippet__dots">
          <div className="snippet__dot"></div>
          <div className="snippet__dot"></div>
          <div className="snippet__dot"></div>
        </div>
        <div className="snippet__title">{title}</div>
      </div>
      <CodeBlock {...other}>{trimSnippet(snippet)}</CodeBlock>
    </div>
  );
};

export function AutoSnippet(props: {
  title?: string;
  language?: string;
  codegen: string | Array<string>;
  hooksCodegen: string | Array<string>;
  raw: string | Array<string>;
  hooks: string | Array<string>;
}) {
  let snippet: string | Array<string>;
  snippet = props.raw;

  const code = Array.isArray(snippet) ? snippet.join("\n") : snippet;

  return (
    <CodeBlock language={props.language} title={props.title}>
      {trimSnippet(code)}
    </CodeBlock>
  );
}

export function ConditionalSnippet(props: {
  children: string;
}) {
  return props.children
}
