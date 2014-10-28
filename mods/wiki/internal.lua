
wikilib.internal_pages = {
----------------------------------------------------------------
----------------------------------------------------------------
[".Intro"] = [[
Thank you for using the Wiki Mod.

This is a mod that allows one to edit pages via a block. You
can use it to document interesting places in a server, to provide
a place to post griefing reports, or any kind of text you want.

To create a new page, enter the name in the field at the top of the
form, then click "Go". If the page already exists, it's contents will
be displayed. Edit the page as you see fit, then click on "Save" to
write the changes to disk.

Please note that page names starting with a dot ('.') are reserved
for internal topics such as this one. Users cannot edit/create such
pages from the mod interface.

See also:
  * [.Tags]
  * [.License]
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".Tags"] = [[
The wiki supports some special tags.

You can place hyperlinks to other pages in the Wiki, by surrounding
text in square brackets (for example, [.Intro]). Such links will
appear at the bottom of the form.

See also:
  * [.Intro]
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".License"] = [[

Copyright (c) 2013, Diego Martínez
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

  * Go to [.Intro].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".NotFound_Internal"] = [[
The specified internal page cannot be found. You may want to:

  * Back to [Main].
  * Go to [.Intro].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".NotFound"] = [[
This page does not exist yet.

  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".BadPageName"] = [[
The page name you entered is wrong. See [.Page Names] for more info.

  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".Forbidden"] = [[
You have not enough privileges to view this page.

  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".Help Index"] = [[
  * [.Page Names]
  * [.User Pages]

  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".Page Names"] = [[
Page names must be in any of the following formats:
  <pagename>
    Display global page <pagename>.
  :<n>
    Display page <n> from your user space. <n> must be a number between
    0 and 9. See [.User Pages] for more info.
  :
    This is equivalent to ":0" (shows your private page).
  :<user>:<n>
    Display page "Page Name" from the specified user's space. Note that page
    number 0 is never accessible this way, even if you specify yourself as
    <user>.

  * Back to [.Help Index].
  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".User Pages"] = [[
Users can have up to 10 pages in their "user space", numbered 0-9. These pages
are accessed through the special page names ":<n>", and ":<user>:<n>". Page 0
is your private page. This page is not accessible to anyone but you. You can
use it to write down secret locations, etc.

  * Back to [.Help Index].
  * Back to [Main].
]],
----------------------------------------------------------------
----------------------------------------------------------------
[".My Pages"] = [[
  * Profile: [:profile]
  * Private page: [:0]
  * Pages: [:1] [:2] [:3] [:4] [:5] [:6] [:7] [:8] [:9]
]],
----------------------------------------------------------------
----------------------------------------------------------------
}
