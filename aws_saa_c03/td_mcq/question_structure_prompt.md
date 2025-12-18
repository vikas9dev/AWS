## TD MCQ Editing & Formatting Guidelines

Use these rules when editing any files under `aws_saa_c03/td_mcq`.

### 1. Question structure

- **Question headings**
  - Each question must start with an H2-style heading:  
    - `## Question 1`, `## Question 2`, etc. (or `## **Question 1**` in topic-based files, matching existing style).
  - The heading appears **immediately before** the question text.

- **Question body**
  - Question stem and options are written in normal Markdown (bold for question text, bullet list for options), following the patterns already used in `01_ec2.md`.

### 2. Answer “show/hide” block

- **Use `<details>` for collapsible answers**
  - Wrap every explanation in:
    ```html
    <details>
      <summary><strong>Answer & Explanation</strong> 📝</summary>
      <!-- explanation content here -->
    </details>
    ```
  - The summary text **must** be exactly:  
    `<strong>Answer & Explanation</strong> 📝` (bold via `<strong>`, followed by a single emoji).

- **Explanation content style**
  - Inside the `<details>` block:
    - Start with a clear “Correct Answer” section, e.g. `### ✅ Correct Answer` or similar. 
    - It may start with "Note" or "Hint" which is very curical for the answer. 
    - Follow with clearly labeled sections for incorrect options, key takeaways, summaries, etc., using consistent Markdown headings (e.g. `### ❌ Why the other options are incorrect`, `### 🧠 Summary`).
  - Follow the overall tone and structure used in `topic-based/01_ec2.md` and the existing section-based files.

### 3. Horizontal rules (`---`)

- **Where `---` is allowed**
  - Use `---` **only** as a separator **between questions** (i.e., after a `</details>` block and before the next `## Question N` heading).

- **Where `---` must be removed**
  - Remove any `---` that appears:
    - **Inside** a `<details>...</details>` block (within the explanation), or
    - **Between** the question/options and the start of the `<details>` block (i.e., directly above `<details>` within the same question).

### 4. Images in explanations

- For large diagrams or screenshots inside these MD files:
  - Prefer HTML `<img>` so you can control size, e.g.:
    ```html
    <img src="https://example.com/image.png"
         alt="Descriptive alt text"
         width="600" />
    ```
  - Target a **medium width** (around `600` px) so images are readable but not huge.

### 5. Consistency expectations

- **Across all MCQ files (`td_mcq`)**:
  - Question headings follow the `Question N` pattern.
  - Every answer/explanation is in a `<details>` block with the standardized `<summary>` text.
  - No stray `---` lines inside explanations or between a question and its `<details>`.
  - Heading levels and labels within explanations (Correct Answer, Incorrect Options, Summary, etc.) stay consistent with the patterns in:
    - `topic-based/01_ec2.md` (topic-style questions), and
    - `section-based/1_Design Resilient Architectures.md` / `3_Design Secure Architectures.md` (section-style questions).

### 6. Highlight incorrect options in red

- Use red text when explicitly calling out **incorrect** options inside the answer/explanation.
- Wrap the label or heading for the wrong option with a red `<span>`, for example:  
  `<span style="color:red"><strong>Option B – Incorrect</strong></span>`
