;;; mql-mode.el --- Simple major mode for editing mql files

;; Copyright (C) 2016 Matúš Goljer <matus.goljer@gmail.com>

;; Author: Matúš Goljer <matus.goljer@gmail.com>
;; Maintainer: Matúš Goljer <matus.goljer@gmail.com>
;; Version: 0.0.1
;; Created: 31st May 2016
;; Keywords: conf

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Major mode for editing mql files: https://www.mql4.com/

;; Similar mode can be found here:
;; https://github.com/kostafey/kostafeys-emacs-confik/blob/master/artifacts/mql-mode.el

;;; Code:

(require 'cc-mode)

;;;###autoload (add-to-list 'auto-mode-alist '("\\.mq4\\'" . mql-mode))

(defvar mql-mode-keywords
  `(("\\<\\(?:Ask\\|B\\(?:ars\\|id\\)\\|Close\\|Digits\\|High\\|Low\\|Open\\|Point\\|\\(?:Ti\\|Volu\\)me\\)\\>"
     . font-lock-builtin-face)
    (,(regexp-opt '(
                    "MODE_STOPLEVEL" "MODE_EMA" "MODE_SMA"
                    "PRICE_CLOSE"
                    "SELECT_BY_TICKET"
                    "INIT_SUCCEEDED"
                    "OP_BUY" "OP_SELL"
                    ))
     . font-lock-constant-face)
    (,(concat "\\<\\(?:A\\(?:ccount\\(?:Balance\\|C\\(?:ompany\\|redit\\|ur"
              "rency\\)\\|Equity\\|FreeMargin\\(?:Check\\|Mode\\)?\\|Levera"
              "ge\\|Margin\\|N\\(?:ame\\|umber\\)\\|Profit\\|S\\(?:erver\\|"
              "topout\\(?:Level\\|Mode\\)\\)\\)\\|lert\\|rray\\(?:Bsearch\\"
              "|Copy\\(?:\\(?:Rat\\|Seri\\)es\\)?\\|Dimension\\|GetAsSeries"
              "\\|I\\(?:nitialize\\|sSeries\\)\\|M\\(?:\\(?:ax\\|in\\)imum"
              "\\)\\|R\\(?:\\(?:ang\\|esiz\\)e\\)\\|S\\(?:etAsSeries\\|ize"
              "\\|ort\\)\\)\\)\\|C\\(?:harToStr\\|omment\\)\\|D\\(?:ay\\(?:"
              "DayOfWeek\\|OfYear\\)\\|oubleToStr\\)\\|File\\(?:Close\\|Del"
              "ete\\|Flush\\|Is\\(?:\\(?:Line\\)?Ending\\)\\|Open\\(?:Histo"
              "ry\\)?\\|Read\\(?:Array\\|Double\\|Integer\\|Number\\|String"
              "\\)\\|S\\(?:eek\\|ize\\)\\|Tell\\|Write\\(?:Array\\|Double\\"
              "|Integer\\|String\\)?\\)\\|G\\(?:et\\(?:LastError\\|TickCoun"
              "t\\)\\|lobalVariable\\(?:Check\\|Del\\|Get\\|Name\\|Set\\(?:"
              "OnCondition\\)?\\|s\\(?:\\(?:DeleteAl\\|Tota\\)l\\)\\)\\)\\|"
              "H\\(?:ideTestIndicators\\|our\\)\\|I\\(?:ndicator\\(?:Buffer"
              "s\\|Counted\\|Digits\\|ShortName\\)\\|s\\(?:Connected\\|D\\("
              "?:emo\\|llsAllowed\\)\\|ExpertEnabled\\|LibrariesAllowed\\|O"
              "ptimization\\|Stopped\\|T\\(?:esting\\|rade\\(?:Allowed\\|Co"
              "ntextBusy\\)\\)\\|VisualMode\\)\\)\\|M\\(?:a\\(?:rketInfo\\|"
              "th\\(?:A\\(?:bs\\|rc\\(?:cos\\|\\(?:si\\|ta\\)n\\)\\)\\|C\\("
              "?:eil\\|os\\)\\|Exp\\|Floor\\|Log\\|M\\(?:ax\\|in\\|od\\)\\|"
              "Pow\\|R\\(?:\\(?:a\\|ou\\)nd\\)\\|S\\(?:in\\|qrt\\|rand\\)\\"
              "|Tan\\)\\)\\|essageBox\\|inute\\|onth\\)\\|NormalizeDouble\\"
              "|O\\(?:bject\\(?:Create\\|De\\(?:lete\\|scription\\)\\|Find"
              "\\|Get\\(?:FiboDescription\\|ShiftByValue\\|ValueByShift\\)?"
              "\\|Move\\|Name\\|Set\\(?:FiboDescription\\|Text\\)?\\|Type\\"
              "|s\\(?:\\(?:DeleteAl\\|Tota\\)l\\)\\)\\|rder\\(?:C\\(?:lose"
              "\\(?:By\\|\\(?:Pric\\|Tim\\)e\\)?\\|omm\\(?:ent\\|ission\\)"
              "\\)\\|Delete\\|Expiration\\|Lots\\|M\\(?:agicNumber\\|odify"
              "\\)\\|Open\\(?:\\(?:Pric\\|Tim\\)e\\)\\|Pr\\(?:\\(?:in\\|ofi"
              "\\)t\\)\\|S\\(?:e\\(?:lect\\|nd\\)\\|topLoss\\|wap\\|ymbol\\"
              ")\\|T\\(?:akeProfit\\|icket\\|ype\\)\\|s\\(?:\\(?:History\\)"
              "?Total\\)\\)\\)\\|P\\(?:eriod\\|laySound\\|rint\\)\\|Refresh"
              "Rates\\|S\\(?:e\\(?:conds\\|nd\\(?:FTP\\|Mail\\)\\|t\\(?:Ind"
              "ex\\(?:Arrow\\|Buffer\\|DrawBegin\\|EmptyValue\\|Label\\|S\\"
              "(?:hift\\|tyle\\)\\)\\|Level\\(?:\\(?:Styl\\|Valu\\)e\\)\\)"
              "\\)\\|leep\\|tr\\(?:To\\(?:Double\\|Integer\\|Time\\)\\|ing"
              "\\(?:Concatenate\\|Find\\|GetChar\\|Len\\|S\\(?:\\(?:etCha\\"
              "|ubst\\)r\\)\\|Trim\\(?:\\(?:Lef\\|Righ\\)t\\)\\)\\)\\|ymbol"
              "\\)\\|T\\(?:erminal\\(?:Company\\|Name\\|Path\\)\\|ime\\(?:C"
              "urrent\\|Day\\(?:Of\\(?:Week\\|Year\\)\\)?\\|Hour\\|Local\\|"
              "M\\(?:inute\\|onth\\)\\|Seconds\\|\\(?:ToSt\\|Yea\\)r\\)\\)"
              "\\|UninitializeReason\\|Window\\(?:BarsPerChart\\|ExpertName"
              "\\|Fi\\(?:nd\\|rstVisibleBar\\)\\|Handle\\|IsVisible\\|OnDro"
              "pped\\|Price\\(?:M\\(?:ax\\|in\\)\\|OnDropped\\)\\|Redraw\\|"
              "ScreenShot\\|TimeOnDropped\\|XOnDropped\\|YOnDropped\\|sTota"
              "l\\)\\|Year\\|i\\(?:A\\(?:DX\\|TR\\|lligator\\|[CDO]\\)\\|B"
              "\\(?:WMFI\\|a\\(?:nds\\(?:OnArray\\)?\\|r\\(?:Shift\\|s\\)\\"
              ")\\|\\(?:ear\\|ull\\)sPower\\)\\|C\\(?:CI\\(?:OnArray\\)?\\|"
              "lose\\|ustom\\)\\|DeMarker\\|Envelopes\\(?:OnArray\\)?\\|F\\"
              "(?:orce\\|ractals\\)\\|Gator\\|High\\(?:est\\)?\\|Ichimoku\\"
              "|Low\\(?:est\\)?\\|M\\(?:A\\(?:CD\\|OnArray\\)?\\|FI\\|oment"
              "um\\(?:OnArray\\)?\\)\\|O\\(?:BV\\|pen\\|sMA\\)\\|R\\(?:SI\\"
              "(?:OnArray\\)?\\|VI\\)\\|S\\(?:AR\\|t\\(?:dDev\\(?:OnArray\\"
              ")?\\|ochastic\\)\\)\\|Time\\|Volume\\|WPR\\)\\)\\>")
     . font-lock-function-name-face)))

;;;###autoload
(define-derived-mode mql-mode c++-mode "Mql"
  "Major mode for Mql files."
  (font-lock-add-keywords nil mql-mode-keywords))

(provide 'mql-mode)
;;; mql-mode.el ends here
