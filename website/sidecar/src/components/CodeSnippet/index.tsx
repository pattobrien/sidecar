import React, { ReactElement, useContext, useEffect, useState } from "react";
import CodeBlock from "@theme/CodeBlock";

const SKIP = "/* SKIP */";
const SKIP_END = "/* SKIP END */";
const START_AT = "/* SNIPPET START */";
const END_AT = "/* SNIPPET END */";

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
