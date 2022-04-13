# Resume Routes

## Description

Everything here is routed through /resume/...

### Routing

- [`/resume/`](RESUME.md)
  - Displays a list of the currently logged in user's resumes providing view, edit, and delete buttons.
  - Displays a 404 not found page or redirects to [`/auth/signin/`](../auth/SIGN_IN.md) for users that aren't signed in.
- [`/resume/<int:pk>/`](VIEW_RESUME.md)
  - Displays the resume with the id specified by `pk`.
  - Provides an edit button linking to [`/resume/builder/<int:pk>`](EDIT_RESUME.md) if the viewer is the owner of the resume.
  - Displays a 404 not found error for resumes that aren't published.
    - Not planned but a good idea
- [`/resume/builder/`](RESUME_BUILDER.md)
  - Displays the resume builder for a brand new resume.
  - Redirects guests to the [`/auth/signin/`](../auth/SIGN_IN.md) page.
- [`/resume/builder/<int:pk>`](EDIT_RESUME.md)
  - Displays the resume builder for an existing resume specified by `pk` belonging to the signed in user.
  - Redirects users who don't own the resume to [`/resume/`](MY_RESUMES.md).
  - Redirects users who aren't signed in to [`/auth/signin/`](../auth/SIGN_IN.md).
