import SwiftUI

public struct AppDesignSystemCatalogView: View {
    @State private var searchText = ""
    @State private var notificationsEnabled = true
    @State private var selectedContext = CatalogContext.inbox
    @State private var selectedWorkspace = Workspace.platform
    @State private var selectedLaunchMode = LaunchMode.guided
    @State private var selectedTab = AppArea.home
    @State private var reviewProgress = 0.68
    @State private var tripName = "Summer escape"
    @State private var tripStartDate = Date.now
    @State private var tripEndDate = Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now
    @State private var placeholderMeals = 6
    @State private var prepNotes = "Focus on reusable meal patterns, quick setup, and a calm first-run editor."

    private enum CatalogContext: String, Hashable, Sendable {
        case inbox
        case projects
        case archive
    }

    private enum Workspace: String, Hashable, Sendable {
        case platform
        case growth
        case brand
    }

    private enum LaunchMode: String, Hashable, Sendable {
        case guided
        case instant
        case review
    }

    private enum AppArea: String, Hashable, Sendable {
        case home
        case tasks
        case library
        case settings
    }

    public init() { }

    public var body: some View {
        AppPage {
            AppPosterHero(
                brand: "AppDesignSystem",
                title: "A reusable SwiftUI system for calm, structured product UI.",
                detail: "Build setup flows, summaries, navigation, and state handling without rebuilding the same shells in every app."
            ) {
                HStack(spacing: 12) {
                    AppButton("Start from hero", systemImage: "arrow.right") { }
                    AppButton(
                        "Review components",
                        systemImage: "square.grid.2x2",
                        intent: .neutral,
                        emphasis: .subtle
                    ) { }
                }
            } visual: {
                AppHeroImage(
                    systemImage: "rectangle.3.group.bubble.left",
                    tintRole: .accentForeground
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        AppTag("Package", systemImage: "shippingbox", tone: .accent)
                        Text("The first screen uses one strong visual plane, but the rest of the system stays grounded in standard app structure.")
                            .appTextStyle(.caption, color: .accentForeground)
                    }
                }
            }
            .accessibilitySortPriority(10)

            AppSearchBar(
                text: $searchText,
                prompt: "Search components, tokens, or patterns"
            )

            AppSegmentedControl(
                selection: $selectedContext,
                segments: [
                    AppSegment(value: .inbox, title: "Inbox", systemImage: "tray"),
                    AppSegment(value: .projects, title: "Projects", systemImage: "square.grid.2x2"),
                    AppSegment(value: .archive, title: "Archive", systemImage: "archivebox")
                ]
            )

            AppSection {
                AppSectionHeader(
                    title: "Buttons",
                    detail: "Intent, emphasis, and accessible touch targets are built in."
                )

                VStack(alignment: .leading, spacing: 12) {
                    AppButton("Primary", systemImage: "arrow.right") { }
                    AppButton(
                        "Secondary",
                        systemImage: "line.3.horizontal.decrease",
                        intent: .neutral,
                        emphasis: .subtle
                    ) { }
                    AppButton(
                        "Destructive",
                        systemImage: "trash",
                        intent: .critical,
                        emphasis: .strong
                    ) { }
                }
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "Inputs and filters",
                    detail: "Search, form fields, and segmented context controls share the same tone and spacing rules."
                )

                AppTextField(
                    "Project name",
                    text: $searchText,
                    prompt: "Atlas redesign",
                    systemImage: "square.and.pencil",
                    helperText: "Field states and labels stay explicit without extra view glue."
                )

                HStack {
                    AppTag("Editorial", systemImage: "text.alignleft", tone: .neutral)
                    AppTag("Shipping", systemImage: "checkmark.circle.fill", tone: .success)
                    AppTag("Brand", systemImage: "sparkles", tone: .accent)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                AppToggleRow(
                    title: "Priority notifications",
                    subtitle: "Keep urgent task updates visible across compact and regular layouts.",
                    isOn: $notificationsEnabled
                )

                AppMenuField(
                    "Workspace",
                    selection: $selectedWorkspace,
                    options: [
                        AppSelectionOption(
                            value: .platform,
                            title: "Platform",
                            detail: "Tokens, infrastructure, and package maintenance",
                            systemImage: "shippingbox"
                        ),
                        AppSelectionOption(
                            value: .growth,
                            title: "Growth",
                            detail: "Campaign surfaces and reporting",
                            systemImage: "chart.line.uptrend.xyaxis"
                        ),
                        AppSelectionOption(
                            value: .brand,
                            title: "Brand",
                            detail: "Editorial direction and launch assets",
                            systemImage: "sparkles"
                        )
                    ],
                    helperText: "Menu fields work well for compact selection flows without introducing a dedicated picker screen."
                )
            }

            AppFormScaffold(
                title: "Editor patterns",
                detail: "Grouped editors and form scaffolds should be reusable across planning, setup, and content-entry apps."
            ) {
                AppSection(tone: .standard) {
                    AppDateField(
                        "Start date",
                        selection: $tripStartDate,
                        helperText: "Compact date entry works well for trip setup and scheduling flows."
                    )

                    AppDateField(
                        "End date",
                        selection: $tripEndDate
                    )

                    AppStepperRow(
                        title: "Placeholder meals",
                        detail: "Use stepper rows for bounded planning values.",
                        value: $placeholderMeals,
                        in: 0...12,
                        tintRole: .accentSecondary
                    )

                    AppMultilineField(
                        "Planning notes",
                        text: $prepNotes,
                        prompt: "Add guidance, reminders, or setup notes",
                        helperText: "Multiline fields should feel like part of the same system, not a fallback to raw SwiftUI."
                    )
                }

                AppValidationSummary(
                    messages: [
                        "Trip name should describe the holiday clearly.",
                        "Start date must be before the end date."
                    ],
                    tone: .warning
                )
            }

            AppSection {
                AppSectionHeader(
                    title: "Messages",
                    detail: "Feedback is quiet, direct, and role-based."
                )

                AppBanner(
                    title: "Theme aware by default",
                    message: "Every component resolves colors through the package theme instead of relying on raw app-level overrides.",
                    tone: .accent
                )

                AppBanner(
                    title: "Reduced motion supported",
                    message: "Interaction feedback collapses to near-instant transitions when Reduce Motion is active.",
                    tone: .neutral
                )
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "Workflow states",
                    detail: "Loading and modal scaffolds keep incomplete states from turning into ad hoc layouts."
                )

                AppLoadingState(
                    title: "Syncing design tokens",
                    message: "Refreshing package previews and semantic color roles.",
                    placeholderRows: 4
                )
            }

            AppSplitWorkspace {
                AppSection(tone: .standard) {
                    AppSectionHeader(
                    title: "Metrics",
                    detail: "Compact data display primitives keep dashboards readable without turning into a card mosaic."
                )

                    HStack(spacing: 12) {
                        AppMetric(
                            title: "Adoption",
                            value: "84%",
                            delta: "+12%",
                            tone: .success
                        )
                        AppMetric(
                            title: "Open reviews",
                            value: "19",
                            delta: "Needs focus",
                            tone: .warning
                        )
                    }

                    AppSummaryPanel(
                        title: "Trip summary",
                        detail: "Key-value rows and action panels replace a lot of repeated hand-built shells."
                    ) {
                        AppKeyValueRow(title: "Meals planned", value: "18", valueRole: .accent)
                        Divider()
                        AppKeyValueRow(title: "Servings", value: "72", valueRole: .accentSecondary)
                        Divider()
                        AppKeyValueRow(title: "Pending reviews", value: "3", valueRole: .accentTertiary)
                    }

                    AppProgressStrip(
                        title: "Preview catalog coverage",
                        value: reviewProgress,
                        detail: "Catalog examples updated for composition, media, motion, and navigation."
                    )
                }
            } secondary: {
                AppInspectorPanel(
                    title: "Inspector",
                    detail: "Secondary context belongs in a clear panel instead of a stack of utility cards."
                ) {
                    VStack(alignment: .leading, spacing: 16) {
                        AppMediaBlock(
                            title: "Launch art direction",
                            detail: "Use media blocks when an image or visual artifact should carry context."
                        ) {
                            AppHeroImage(
                                systemImage: "photo.on.rectangle.angled",
                                tintRole: .accentEmphasis
                            )
                        }

                        HStack(spacing: 12) {
                            AppAvatar(initials: "DS", size: .large)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Owned by design systems")
                                    .appTextStyle(.bodyEmphasis)
                                Text("Reusable across starter apps and internal tools.")
                                    .appTextStyle(.caption, color: .contentSecondary)
                            }
                        }
                    }
                }
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "Selection patterns",
                    detail: "Radio groups handle explicit one-of-many decisions where the available choices need context."
                )

                AppRadioGroup(
                    title: "Launch mode",
                    selection: $selectedLaunchMode,
                    options: [
                        AppSelectionOption(
                            value: .guided,
                            title: "Guided setup",
                            detail: "Walk through theme, sections, and starter screens.",
                            systemImage: "wand.and.stars"
                        ),
                        AppSelectionOption(
                            value: .instant,
                            title: "Instant scaffold",
                            detail: "Start from package defaults with no extra prompts.",
                            systemImage: "bolt.fill"
                        ),
                        AppSelectionOption(
                            value: .review,
                            title: "Review before create",
                            detail: "Approve the structure before the workspace is generated.",
                            systemImage: "doc.text.magnifyingglass"
                        )
                    ]
                )
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "Recovery and actions",
                    detail: "Offline, retry, and next-step prompts should be one reusable surface rather than repeated custom stacks."
                )

                AppStatePanel(
                    title: "Everything you plan stays on this device",
                    message: "Couldn’t load this part of the workflow right now. Try again, or keep working with the data that is already available.",
                    tone: .warning,
                    primaryTitle: "Try Again",
                    secondaryTitle: "Continue Planning",
                    primaryAction: { },
                    secondaryAction: { }
                )

                AppActionPanel(
                    title: "Next step",
                    message: "Generate the next pass from your current setup, or keep editing before you commit.",
                    primaryTitle: "Generate",
                    secondaryTitle: "Keep Editing",
                    primaryAction: { },
                    secondaryAction: { }
                )
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "List rows",
                    detail: "Rows stay dense but readable without leaning on heavy card chrome."
                )

                VStack(spacing: 0) {
                    AppListRow(
                        title: "Onboarding flow",
                        subtitle: "Three-step task flow with adaptive layout",
                        systemImage: "rectangle.stack.person.crop"
                    ) {
                        AppTag("Live", tone: .accent)
                    }

                    Divider()

                    AppListRow(
                        title: "Performance audit",
                        subtitle: "Motion tuned for 60fps and reduced-motion fallback",
                        systemImage: "speedometer"
                    ) {
                        AppTag("Ready", tone: .success)
                    }
                }
            }

            AppGroupedListSection(
                title: "Grouped summary",
                detail: "Apps like planners, study tools, and mapping utilities all converge on this sort of grouped row shell."
            ) {
                AppListRow(
                    title: "Recent setup draft",
                    subtitle: "Trip setup, study session, or onboarding progress",
                    systemImage: "clock.arrow.circlepath"
                ) {
                    AppTag("Draft", tone: .warning)
                }
                Divider()
                AppListRow(
                    title: "Latest generated result",
                    subtitle: "Saved output ready to reopen",
                    systemImage: "checkmark.circle"
                ) {
                    AppTag("Saved", tone: .success)
                }
            }

            AppSection {
                AppSectionHeader(
                    title: "Navigation primitives",
                    detail: "Tabs and sidebars keep app structure consistent across compact and expanded layouts."
                )

                AppTabBar(
                    selection: $selectedTab,
                    items: [
                        AppTabItem(value: .home, title: "Home", systemImage: "house"),
                        AppTabItem(value: .tasks, title: "Tasks", systemImage: "checklist", badge: "3"),
                        AppTabItem(value: .library, title: "Library", systemImage: "books.vertical"),
                        AppTabItem(value: .settings, title: "Settings", systemImage: "slider.horizontal.3")
                    ]
                )

                AppSidebarSection(
                    title: "Sidebar section",
                    detail: "Use this pattern in iPad or Mac sidebars, or as a structured inspector rail."
                ) {
                    AppSidebarItem(
                        value: AppArea.home,
                        selection: $selectedTab,
                        title: "Overview",
                        subtitle: "System health and recent activity",
                        systemImage: "rectangle.grid.1x2"
                    )
                    AppSidebarItem(
                        value: AppArea.tasks,
                        selection: $selectedTab,
                        title: "Pending tasks",
                        subtitle: "Actions waiting on design review",
                        systemImage: "checklist"
                    )
                    AppSidebarItem(
                        value: AppArea.library,
                        selection: $selectedTab,
                        title: "Reference library",
                        subtitle: "Saved screens, notes, and components",
                        systemImage: "books.vertical"
                    )
                }
                .appSurface(.standard)
            }

            AppSection(tone: .standard) {
                AppSectionHeader(
                    title: "Timeline",
                    detail: "Structured progress should read like a calm sequence, not a wall of containers."
                )

                VStack(alignment: .leading, spacing: 0) {
                    AppTimelineRow(
                        title: "Foundation shipped",
                        detail: "Theme, spacing, typography, and surface tokens are established.",
                        timestamp: "Today"
                    )
                    AppTimelineRow(
                        title: "Flow components added",
                        detail: "Modal, search, segmented controls, and menu fields are integrated.",
                        timestamp: "Next",
                        isComplete: false
                    )
                }
            }

            AppSection {
                AppSectionHeader(
                    title: "Modal tasks",
                    detail: "Sheets and focused task flows get their own scaffold instead of bespoke spacing and sticky-footer code."
                )

                AppModalScaffold(
                    title: "Create collection",
                    detail: "Add a focused destination for saved references, screenshots, and notes.",
                    primaryTitle: "Create",
                    secondaryTitle: "Cancel",
                    primaryAction: { },
                    secondaryAction: { }
                ) {
                    VStack(alignment: .leading, spacing: 16) {
                        AppTextField(
                            "Collection title",
                            text: .constant("Spring launch"),
                            prompt: "Title",
                            systemImage: "bookmark"
                        )

                        AppBanner(
                            title: "Shared with the design team",
                            message: "Members can add captures and annotations after the sheet closes.",
                            tone: .neutral
                        )
                    }
                }
                .appSurface(.standard, padded: false)
            }

            AppEmptyState(
                systemImage: "square.and.pencil",
                title: "Build a new screen from the package.",
                message: "Start with AppPage, layer AppSection blocks, then drop in semantic components instead of custom one-off styling.",
                actionTitle: "Create Layout"
            ) { }

            AppBottomActionBar(
                primaryTitle: "Ship next batch",
                secondaryTitle: "Review tokens",
                primaryAction: { },
                secondaryAction: { }
            )
        }
    }
}

#if DEBUG
private struct AppDesignSystemCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeProvider {
            AppDesignSystemCatalogView()
        }
    }
}
#endif
